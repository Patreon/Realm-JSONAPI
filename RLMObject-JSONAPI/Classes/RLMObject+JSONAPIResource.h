#import <Realm/Realm.h>

@interface RLMObject (JSONAPIResource)

+ (NSDictionary *)JSONtoModelMap;

+ (NSString *)type;

+ (NSArray *)defaultAttributes;
+ (NSArray *)defaultRelationships;

+ (Class)classForRelationship:(NSString *)relationshipKey;

@end
