#import "RLMObject+JSONAPIURL.h"
#import "RLMObject+JSONAPIResource.h"
#import "JSONAPIURLUtilities.h"

@implementation RLMObject (JSONAPIURL)

+ (NSArray<NSString *> *)defaultAttributes {
  return nil;
}

+ (NSArray<NSString *> *)defaultRelationships {
  return nil;
}

+ (NSDictionary<NSString *, NSArray<NSString *> *> *)defaultAttributesAsFieldsDictionary {
  NSArray *defaultAttributes = [self defaultAttributes];
  if (defaultAttributes != nil) {
    return @{[self type]: [self defaultAttributes]};
  } else {
    return @{};
  }
}

+ (NSDictionary<NSString *, NSArray<NSString *> *> *)fieldsIncludingRelationships:(NSArray<NSString *> *)relationships {
  NSMutableDictionary *fields = [NSMutableDictionary dictionaryWithCapacity:(1 + relationships.count)];
  [fields addEntriesFromDictionary:[self defaultAttributesAsFieldsDictionary]];
  for (NSString *relationshipKey in relationships) {
    NSArray *relationshipPathKeys = [relationshipKey componentsSeparatedByString:@"."];
    NSString *firstRelationshipKey = [relationshipPathKeys firstObject];
    Class relatedClass = [self classForRelationship:firstRelationshipKey];
    if (relationshipPathKeys.count > 1) {
      NSArray *relationshipPathTailKeys = [relationshipPathKeys subarrayWithRange:NSMakeRange(1, relationshipPathKeys.count - 1)];
      NSString *relationshipPathTailString = [relationshipPathTailKeys componentsJoinedByString:@"."];
      NSDictionary *relatedFields = [relatedClass fieldsIncludingRelationships:@[relationshipPathTailString]];
      [fields addEntriesFromDictionary:relatedFields];
    } else {
      [fields addEntriesFromDictionary:[relatedClass defaultAttributesAsFieldsDictionary]];
    }
  }
  return fields;
}

+ (NSString *)defaultURLDecoration:(NSString *)bareURL {
  return [JSONAPIURLUtilities specifiedURLForBareURL:bareURL
                                        withIncludes:[self defaultRelationships]
                                           andFields:[self fieldsIncludingRelationships:[self defaultRelationships]]];
}

@end
