#import "RLMObject+JSONAPISerializer.h"
#import "RLMObject+JSONAPIResource.h"
#import "JSONAPIResourceRegistry.h"
#import "NSDate+ISO8601.h"

@implementation RLMObject (JSONAPISerializer)

- (NSDictionary<NSString *, id> *)toJSON {
  return [[self toJSONWithIncludedTypes:[NSSet set]] objectForKey:@"data"];
}

- (NSDictionary<NSString *, id> *)toJSONWithIncludedTypes:(NSSet<NSString *> *)types {
  NSMutableSet *included = [NSMutableSet set];
  NSMutableDictionary *data = [self toJSONWithIncludedTypes:types
                                              inIncludedSet:included];
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjectsAndKeys:data, @"data", nil];
  if ([included count] > 0) {
    [result setObject:[included allObjects]
               forKey:@"included"];
  }
  return result;
}

- (NSMutableDictionary<NSString *, id> *)toJSONWithIncludedTypes:(NSSet<NSString *> *)types
                                                   inIncludedSet:(NSMutableSet *)included
{
  NSMutableDictionary *result = [NSMutableDictionary dictionary];
  NSMutableDictionary *links = [NSMutableDictionary dictionary];
  NSDictionary        *map = [[self class] JSONtoModelMap];
  RLMSchema           *schema = self.realm ? self.realm.schema : [RLMRealm defaultRealm].schema;
  Class                class = [self class];
  class = [class superclass];
  RLMObjectSchema     *objectSchema = schema[NSStringFromClass(class)];

  for (NSString *jsonPath in map) {
    NSString *objectKeyPath = map[jsonPath];
    id value = [self valueForKeyPath:objectKeyPath];
    if (value) {
      RLMProperty  *realmProperty = objectSchema[objectKeyPath];
      Class propertyClass = NSClassFromString(realmProperty.objectClassName);
      if ([propertyClass isSubclassOfClass:[RLMObject class]]
          && [realmProperty type] != RLMPropertyTypeArray)
      {
        NSString *typeString = [[JSONAPIResourceRegistry sharedInstance] jsonTypeStringForClass:propertyClass];
        NSDictionary *linkage = @{@"data": @{@"type": typeString,
                                             @"id": value[[[value class] primaryKey]]}};
        [links setObject:linkage forKey:jsonPath];
        [result setObject:links forKey:@"relationships"];

        if ([types containsObject:typeString]) {
          [included addObject:[value toJSONWithIncludedTypes:types
                                               inIncludedSet:included]];
        }
      }
      else if ([propertyClass isSubclassOfClass:[RLMArray class]]
               || [realmProperty type] == RLMPropertyTypeArray)
      {
        NSMutableArray *array = [NSMutableArray array];
        for (id item in(RLMArray *) value) {
          NSString *typeString = [[JSONAPIResourceRegistry sharedInstance] jsonTypeStringForClass:propertyClass];
          NSDictionary *linkage = @{@"type": typeString,
                                    @"id": item[[[item class] primaryKey]]};
          [array addObject:linkage];

          if ([types containsObject:typeString]) {
            [included addObject:[item toJSONWithIncludedTypes:types
                                                 inIncludedSet:included]];
          }
        }
        [links setObject:@{@"data": array} forKey:jsonPath];
        [result setObject:links forKey:@"relationships"];
      } else {
        if ([propertyClass isSubclassOfClass:[NSDate class]] || realmProperty.type == RLMPropertyTypeDate) {
          NSDate *date = (NSDate *)value;
          value = [date ISO8601String];
        }
        NSString *fullJSONPath = jsonPath;
        if (![fullJSONPath isEqualToString:@"id"]) {
          fullJSONPath = [@"attributes." stringByAppendingString:fullJSONPath];
        }
        NSArray *keyPathComponents = [fullJSONPath componentsSeparatedByString:@"."];
        id currentDictionary = result;
        for (NSString *component in keyPathComponents) {
          if ([currentDictionary valueForKey:component] == nil) {
            [currentDictionary setValue:[NSMutableDictionary dictionary] forKey:component];
          }
          currentDictionary = [currentDictionary valueForKey:component];
        }
        [result setValue:value forKeyPath:fullJSONPath];
      }
    }
  }
  result[@"type"] = [[JSONAPIResourceRegistry sharedInstance] jsonTypeStringForClass:class];
  return [result mutableCopy];
}

@end
