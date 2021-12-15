#import "RLMObject+JSONAPIResource.h"
#import "JSONAPIResourceRegistry.h"

@implementation RLMObject (JSONAPIResource)

+ (NSDictionary<NSString *, NSString *> *)JSONtoModelMap {
  return nil;
}

+ (NSString *)type {
  NSString *type = [JSONAPIResourceRegistry.sharedInstance jsonTypeStringForClass:[self class]];
  Class klass = [self class];
  while (!type && (klass = [klass superclass])) {
    type = [JSONAPIResourceRegistry.sharedInstance jsonTypeStringForClass:klass];
  }
  return type;
}

+ (Class)classForRelationship:(NSString *)relationshipKey {
  NSDictionary *map = self.JSONtoModelMap;
  RLMSchema *schema = [RLMRealm defaultRealm].schema;
  Class class = [self class];
  class = [class superclass];

  RLMObjectSchema *objectSchema = schema[NSStringFromClass(class)];
  NSString *propertyStringForRelationship = map[relationshipKey];
  RLMProperty *realmProperty = objectSchema[propertyStringForRelationship];
  return NSClassFromString(realmProperty.objectClassName);
}

@end
