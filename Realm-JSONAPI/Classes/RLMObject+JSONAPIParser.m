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

  [self parseIDAndAttributesFromJSON:json
                     intoModelValues:model
                            forRealm:realm
                 usingJSONtoModelMap:map
                     andObjectSchema:objectSchema];

  [self parseRelationshipsFromJSON:json
                   intoModelValues:model
                          forRealm:realm
               usingJSONtoModelMap:map
                   andObjectSchema:objectSchema];

  return model;
}

+ (void)parseIDAndAttributesFromJSON:(NSDictionary *)json
                     intoModelValues:(NSMutableDictionary *)model
                            forRealm:(RLMRealm *)realm
                 usingJSONtoModelMap:(NSDictionary *)jsonToModelMap
                     andObjectSchema:(RLMObjectSchema *)objectSchema
{
  for (NSString *jsonPath in jsonToModelMap) {
    NSString    *modelProperty = jsonToModelMap[jsonPath];
    RLMProperty *realmProperty = objectSchema[modelProperty];
    if (!realmProperty) {
      // Here we have an attribute in the JSON with no equivalent model property
      // so we don't try to parse it
      continue;
    }

    id value = [self getValueFromJSON:json
                               atPath:jsonPath];
    if (!value || value == [NSNull null]) {
      continue;
    }

    if (realmProperty.type == RLMPropertyTypeObject)
    {
      Class propertyClass = NSClassFromString(realmProperty.objectClassName);
      RLMObject *realmObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:[value stringValue]];
      if (realmObject) {
        model[modelProperty] = realmObject;
      }
    }
    else if (realmProperty.type == RLMPropertyTypeString)
    {
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
    }
    else if (realmProperty.type == RLMPropertyTypeDate)
    {
      NSDate *date = [NSDate dateFromISO8601String:value];
      if (date) {
        model[modelProperty] = date;
      }
    }
    else
    {
      model[modelProperty] = value;
    }
  }
}

+ (id)getValueFromJSON:(NSDictionary *)json
                atPath:(NSString *)jsonPath
{
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
  return value;
}

+ (void)parseRelationshipsFromJSON:(NSDictionary *)json
                   intoModelValues:(NSMutableDictionary *)model
                          forRealm:(RLMRealm *)realm
               usingJSONtoModelMap:(NSDictionary *)jsonToModelMap
                   andObjectSchema:(RLMObjectSchema *)objectSchema
{
  NSDictionary *links = json[@"relationships"];
  for (NSDictionary *property in links.keyEnumerator) {
    NSString     *modelProperty = jsonToModelMap[property];
    RLMProperty  *realmProperty = objectSchema[modelProperty];
    if (!realmProperty) {
      // Here we have a relationship in the JSON with no equivalent model property
      // so we don't try to parse it
      continue;
    }

    NSDictionary *link = links[property];
    if (!link || ![link isKindOfClass:[NSDictionary class]] || !link[@"data"]) {
      continue;
    }

    Class propertyClass = NSClassFromString(realmProperty.objectClassName);
    if ([link[@"data"] isKindOfClass:[NSDictionary class]])
    {
      NSString *uid = link[@"data"][@"id"];
      id linkedObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:uid];
      model[modelProperty] = linkedObject;
    }
    else if ([link[@"data"] isKindOfClass:[NSArray class]])
    {
      NSMutableArray *linkedObjects = [NSMutableArray array];
      for (id linkageItem in link[@"data"]) {
        NSString *uid = linkageItem[@"id"];
        id linkedObject = [self realmObjectInRealm:realm withClass:propertyClass andUID:uid];
        [linkedObjects addObject:linkedObject];
      }
      model[modelProperty] = linkedObjects;
    }
    else
    {
      // TODO: linkage is not an array or dictionary.. what to do with it?
    }
  }
}

+ (id)realmObjectInRealm:(RLMRealm *)realm withClass:(Class)cls andUID:(NSString *)uid {
  id object = [cls objectInRealm:realm forPrimaryKey:uid];
  if (object) {
    return object;
  } else {
    NSString *primaryKey = [cls primaryKey];
    return [cls createInDefaultRealmWithValue:@{ primaryKey: uid }];
  }
}

// TODO: construct the json on a bg thread, then put in realm on the main thread
+ (instancetype)createInDefaultRealmWithJSON:(NSDictionary *)json {
  return [self createInRealm:[RLMRealm defaultRealm] withJSON:json];
}

+ (instancetype)createInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json {
  return [self createInRealm:realm withValue:[self mapJSONToModel:json withRealm:realm]];
}

+ (instancetype)createOrUpdateInDefaultRealmWithJSON:(NSDictionary *)json {
  return [self createOrUpdateInRealm:[RLMRealm defaultRealm] withJSON:json];
}

+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json {
  return [self createOrUpdateInRealm:realm withValue:[self mapJSONToModel:json withRealm:realm]];
}

@end
