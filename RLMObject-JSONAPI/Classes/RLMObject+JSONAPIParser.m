#import "RLMObject+JSONAPIParser.h"
#import "RLMObject+JSONAPIResource.h"
#import <Realm/RLMObjectSchema.h>
#import <Realm/RLMProperty.h>
#import "NSDate+ISO8601.h"

@implementation RLMObject (JSONAPIParser)

+ (NSDictionary *)mapJSONToModel:(NSDictionary *)json withRealm:(RLMRealm *)realm {
  NSMutableDictionary *model = [NSMutableDictionary dictionary];
  NSDictionary        *map = [self JSONtoModelMap];
  RLMSchema           *schema = realm.schema;
  RLMObjectSchema     *objectSchema = schema[NSStringFromClass([self class])];

  for (NSString *jsonPath in map) {
    NSString    *modelProperty = map[jsonPath];
    RLMProperty *realmProperty = objectSchema[modelProperty];

    NSString *fullJSONPath = jsonPath;
    NSMutableArray *jsonPathComponents = [NSMutableArray arrayWithCapacity:3];
    if (![fullJSONPath isEqualToString:@"id"]) {
      [jsonPathComponents addObject:@"attributes"];
    }
    [jsonPathComponents addObjectsFromArray:[fullJSONPath componentsSeparatedByString:@"."]];
    id value = json;
    for (NSString *component in jsonPathComponents) {
      value = [value objectForKey:component];
      if (!value || value == [NSNull null]) {
        break;
      }
    }
    if (value && value != [NSNull null]) {
      if (!realmProperty) {
        // Here we have a JSON property with no equivalent model property
        continue;
      } else if (realmProperty.type == RLMPropertyTypeObject) {
        Class propertyClass = NSClassFromString(realmProperty.objectClassName);
        RLMObject *realmObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:[value stringValue]];
        if (realmObject) {
          model[modelProperty] = realmObject;
        }
      } else if (realmProperty.type == RLMPropertyTypeString) {
        NSString *stringValue = nil;
        if ([value isKindOfClass:[NSString class]]) {
          stringValue = (NSString *)value;
        } else if ([value respondsToSelector:@selector(stringValue)]) {
          stringValue = [value stringValue];
        } else {
          stringValue = [NSString stringWithFormat:@"%@", value];
        }
        if (stringValue) {
          model[modelProperty] = stringValue;
        }
      } else if (realmProperty.type == RLMPropertyTypeDate) {
        NSDate *date = [NSDate dateFromISO8601String:value];
        if (date) {
          model[modelProperty] = date;
        }
      } else {
        model[modelProperty] = value;
      }
    }
  }
  NSDictionary *links = json[@"relationships"];
  for (NSDictionary *property in links.keyEnumerator) {
    NSDictionary *link = links[property];
    NSString     *modelProperty = map[property];
    RLMProperty  *realmProperty = objectSchema[modelProperty];
    Class propertyClass = NSClassFromString(realmProperty.objectClassName);

    if (!realmProperty) {
      // Here we have a JSON property with no equivalent model property
      continue;
    }
    else if (link[@"data"]) {
      if ([link[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSString *uid = link[@"data"][@"id"];
        id linkedObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:uid];
        model[modelProperty] = linkedObject;
      } else if ([link[@"data"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *linkedObjects = [NSMutableArray array];
        for (id linkageItem in link[@"data"]) {
          NSString *uid = linkageItem[@"id"];
          id linkedObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:uid];
          [linkedObjects addObject:linkedObject];
        }
        model[modelProperty] = linkedObjects;
      } else {
        // TODO: linkage is null. what to do with it?
      }
    }
    // end API hacks
  }
  return model;
}

// TODO: construct the json on a bg thread, then put in realm on the main thread
+ (instancetype)createInDefaultRealmWithJSON:(NSDictionary *)json {
  return [self createInDefaultRealmWithValue:[self mapJSONToModel:json withRealm:[RLMRealm defaultRealm]]];
}

+ (instancetype)createInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json {
  return [self createInRealm:realm withValue:[self mapJSONToModel:json withRealm:realm]];
}

+ (instancetype)createOrUpdateInDefaultRealmWithJSON:(NSDictionary *)json {
  return [self createOrUpdateInDefaultRealmWithValue:[self mapJSONToModel:json withRealm:[RLMRealm defaultRealm]]];
}

+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json {
  return [self createOrUpdateInRealm:realm withValue:[self mapJSONToModel:json withRealm:realm]];
}

+ (id)realmObjectInRealm:(RLMRealm *)realm withClass:(Class)cls andUID:(NSString *)uid {
  id object = [cls objectInRealm:realm forPrimaryKey:uid];
  if (object) {
    return object;
  } else {
    return [cls createInDefaultRealmWithValue:@{ @"uid" : uid }];
  }
}

@end
