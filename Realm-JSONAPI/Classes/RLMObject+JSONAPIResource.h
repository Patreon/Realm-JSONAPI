#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * This category defines the primary schema by which Realm-JSONAPI does its work:
 * a way to translate between JSON:API Resource Objects and RLMObjects.
 * You should make sure to override `JSONtoModelMap` on your RLMObjects,
 * but you should not need to mess with `type` or `classForRelationship`.
 * This category is also typically not ever imported directly, but rather rides along with RLMObject+JSONAPI.
 *
 * @see JSONtoModelMap
 * @see RLMObject+JSONAPI
 */
@interface RLMObject (JSONAPIResource)

/**
 * The schema which defines how to map a given JSON:API document to and from an RLMObject's properties.
 * This method should be overridden on your RLMObject subclasses
 * to tell Realm-JSONAPI how to do its parsing and serialization.
 *
 * @return An NSDictionary where
 * the keys are the dot-separated keypath of the attributes or relationships within the JSON:API document,
 * and the values are strings which correspond to the names of the properties on your RLMObject.
 * E.g. {"id": @"uid", "name.first": @"firstName", "name.last": @"lastName", "twitter": @"twitterHandle"}
 * would parse {"data": {"id": "1", "type": "people", "attributes": {"name": {"first": "Dan", "last": "Gebhardt"}, "twitter": "dgeb"}}}
 * into a Person model where [person.uid isEqual:@"1"], [person.firstName isEqual:@"Dan"], etc.
 */
@property (class, nonatomic, readonly, nullable) NSDictionary<NSString *, NSString *> *JSONtoModelMap NS_SWIFT_NAME(jsonToModelMap);

/**
 * This method uses the JSONAPIResourceRegistry to look up this class's type string.
 * As such, you should not need to override it yourself,
 * just make sure to always register your classes
 * 
 * @return An NSString that defines the JSON:API type key which refers to the same resource which this RLMObject represents.
 *
 * @see JSONAPIResourceRegistry
 */
@property (class, nonatomic, readonly, nullable) NSString *type;

/**
 * The RLMObject subclass which represents relationships known to this class by the provided relationshipKey
 *
 * @param relationshipKey The string by which an JSON:API Resource Object will know a given relationship.
 * E.g. {"data": {"id": "1", "type": "articles", "attributes": {...}, "relationships": {"author": ..., ...}}}
 * would have "author" as one possible valid relationshipKey
 * @return A subclass of RLMObject (as a class, not an instance)
 * that can be used to represents relationships known by the provided relationshipKey.
 */
+ (nullable Class)classForRelationship:(NSString *)relationshipKey;

@end

NS_ASSUME_NONNULL_END
