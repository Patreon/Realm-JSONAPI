#import "RLMObject+JSONAPIResource.h"
#import "JSONAPIResourceRegistry.h"

@implementation RLMObject (JSONAPIResource)

+ (NSDictionary *)JSONtoModelMap {
  return nil;
}

+ (NSString *)type {
  NSString *type = [[JSONAPIResourceRegistry sharedInstance] jsonTypeStringForClass:[self class]];
  Class klass = [self class];
  while (!type && (klass = [klass superclass])) {
    type = [[JSONAPIResourceRegistry sharedInstance] jsonTypeStringForClass:klass];
  }
  return type;
}

+ (Class)classForRelationship:(NSString *)relationshipKey {
  NSDictionary *map = [self JSONtoModelMap];
  RLMSchema *schema = [RLMRealm defaultRealm].schema;
  Class class = [self class];
  // Realm often subclasses our objects with RLMAccessor, or RLMStandalone if we're not in a Realm
  if ([NSStringFromClass(class) rangeOfString:@"RLMAccessor"].location != NSNotFound
      || [NSStringFromClass(class) rangeOfString:@"RLMStandalone"].location != NSNotFound) {
    class = [class superclass];
  }
  RLMObjectSchema *objectSchema = schema[NSStringFromClass(class)];
  NSString *propertyStringForRelationship = map[relationshipKey];
  RLMProperty *realmProperty = objectSchema[propertyStringForRelationship];
  return NSClassFromString(realmProperty.objectClassName);
}

@end
