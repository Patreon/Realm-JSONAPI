#import <Realm/Realm.h>

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
+ (NSDictionary *)JSONtoModelMap;

/**
 * This method should be overridden on your RLMObject subclasses
 * to assist Realm-JSONAPI's parsing and serialization.
 * 
 * @return An NSString that defines the JSON:API type key which refers to the same resource which this RLMObject represents.
 */
+ (NSString *)type;

/**
 * This method should be overridden on your RLMObject subclasses to assist Realm-JSONAPI's server communication
 * (specifically the JSONAPIURLUtilities methods, which you invoke by hand as desired).
 *
 * @return An NSArray that lists the attributes which you wish to request from the server
 *
 * @see http://jsonapi.org/format/#fetching-sparse-fieldsets
 */
+ (NSArray *)defaultAttributes;

/**
 * This method should be overridden on your RLMObject subclasses to assist Realm-JSONAPI's server communication
 * (specifically the JSONAPIURLUtilities methods, which you invoke by hand as desired).
 *
 * @return An NSArray that lists the related objects which you wish to request from the server
 *
 * @see http://jsonapi.org/format/#fetching-sparse-fieldsets
 */
+ (NSArray *)defaultRelationships;

/**
 * The RLMObject subclass which represents relationships known to this class by the provided relationshipKey
 *
 * @param relationshipKey The string by which an JSON:API Resource Object will know a given relationship.
 * E.g. {"data": {"id": "1", "type": "articles", "attributes": {...}, "relationships": {"author": ..., ...}}}
 * would have "author" as one possible valid relationshipKey
 * @return A subclass of RLMObject (as a class, not an instance)
 * that can be used to represents relationships known by the provided relationshipKey.
 */
+ (Class)classForRelationship:(NSString *)relationshipKey;

@end
