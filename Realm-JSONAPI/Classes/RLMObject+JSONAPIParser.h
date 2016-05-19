#import <Realm/Realm.h>

@interface RLMObject (JSONAPIParser)

/**
 * Add a JSON:API resource object to a given realm, should it not yet be present there.
 *
 * @param json A JSON:API Resource Object
 * @param realm The RLMRealm which you want to add the parsed object.
 * This method *will* add the object to the Realm,
 * unlike -mapJSONToModel:withRealm (which this method uses under the hood)
 * @return An RLMObject subclass instance, representing the same resource as the supplied json
 */
+ (instancetype)createInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json;

/**
 * Same as createInRealm:withJSON:, passing in [RLMRealm defaultRealm] as the realm
 * @see -createInRealm:withJson:
 */
+ (instancetype)createInDefaultRealmWithJSON:(NSDictionary *)json;

/**
 * Add a JSON:API resource object to a given realm,
 * or update one with a matching type and primary key, should it already exist in the realm.
 *
 * @param json A JSON:API Resource Object
 * @param realm The RLMRealm which you want to add the parsed object.
 * This method *will* add the object to the Realm,
 * unlike -mapJSONToModel:withRealm (which this method uses under the hood)
 * @return An RLMObject subclass instance, representing the same resource as the supplied json
 */
+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withJSON:(NSDictionary *)json;

/**
 * Same as createInRealm:withJSON:, passing in [RLMRealm defaultRealm] as the realm
 * @see -createOrUpdateInRealm:withJSON:
 */
+ (instancetype)createOrUpdateInDefaultRealmWithJSON:(NSDictionary *)json;

/**
 * @param json A JSON:API Resource Object
 * @param realm The RLMRealm which you want to add the parsed object.
 * This method will not add the object to the Realm, but it will use the realm's schema during parsing,
 * and find any related resources via querying this realm.
 * @return A flattened map from RLMObject property names to property values, as can be passed to createInRealm:withValue:
 */
+ (NSDictionary *)mapJSONToModel:(NSDictionary *)json withRealm:(RLMRealm *)realm;

@end
