#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * This category handles parsing JSON:API server responses into RLMObjects.
 * It is typically not used directly, but rather invoked by JSONAPIParserUtilities.
 * It is also typically not ever imported directly, but rather rides along with RLMObject+JSONAPI
 *
 * @see JSONAPIParserUtilities
 * @see RLMObject+JSONAPI
 */
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
+ (instancetype)createInRealm:(RLMRealm *)realm withJSON:(NSDictionary<NSString *, id> *)json NS_SWIFT_NAME(create(in:withJSON:));

/**
 * Same as createInRealm:withJSON:, passing in [RLMRealm defaultRealm] as the realm
 * @see -createInRealm:withJson:
 */
+ (instancetype)createInDefaultRealmWithJSON:(NSDictionary<NSString *, id> *)json NS_SWIFT_NAME(createInDefaultRealm(withJSON:));

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
+ (instancetype)createOrUpdateInRealm:(RLMRealm *)realm withJSON:(NSDictionary<NSString *, id> *)json NS_SWIFT_NAME(createOrUpdate(in:withJSON:));

/**
 * Same as createInRealm:withJSON:, passing in [RLMRealm defaultRealm] as the realm
 * @see -createOrUpdateInRealm:withJSON:
 */
+ (instancetype)createOrUpdateInDefaultRealmWithJSON:(NSDictionary<NSString *, id> *)json NS_SWIFT_NAME(createOrUpdateInDefaultRealm(withJSON:));

/**
 * @param json A JSON:API Resource Object
 * @param realm The RLMRealm which you want to add the parsed object.
 * This method will not add the object to the Realm, but it will use the realm's schema during parsing,
 * and find any related resources via querying this realm.
 * @return A flattened map from RLMObject property names to property values, as can be passed to createInRealm:withValue:
 */
+ (NSDictionary<NSString *, id> *)mapJSONToModel:(NSDictionary<NSString *, id> *)json withRealm:(RLMRealm *)realm NS_SWIFT_NAME(mapJSON(_:toModelWith:));

@end

NS_ASSUME_NONNULL_END
