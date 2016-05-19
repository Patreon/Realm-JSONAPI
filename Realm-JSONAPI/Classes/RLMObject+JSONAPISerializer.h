#import <Realm/Realm.h>

@interface RLMObject (JSONAPISerializer)

/**
 * @return This object, as it would be represented in JSON:API format.
 * @note The returned dictionary will *not* be wrapped in {"data": ...}
 * @note This *will* include all relationships as Resource Identifier Objects
 * but will *not* include the full Resource Object.
 * @see http://jsonapi.org/format/#document-resource-identifier-objects for a definition of Resource Identifier Objects
 * @see http://jsonapi.org/format/#document-resource-objects for a definition of Resource Objects
 */
- (NSDictionary *)toJSON;

/**
 * @return This object, as it would be represented in JSON:API format, and its related resources as full Resource Objects.
 * The return format will be {"data": <primary resource data>, "included": [<included resources>, ...]}
 * @see http://jsonapi.org/format/#document-resource-objects for a definition of Resource Objects
 */
- (NSDictionary *)toJSONWithIncludedTypes:(NSSet *)types;

@end
