#import <Realm/Realm.h>

@interface RLMObject (JSONAPIParser)

+ (NSDictionary *)mapJSONToModel:(NSDictionary *)json withRealm:(RLMRealm *)realm;

+ (instancetype)createInDefaultRealmWithJSON:(NSDictionary *)json;
+ (instancetype)createInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json;
+ (instancetype)createOrUpdateInDefaultRealmWithJSON:(NSDictionary *)json;
+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json;

@end
