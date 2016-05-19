#import <Foundation/Foundation.h>

@interface JSONAPIURLUtilities : NSObject

/**
 * Append query parameters to a given URL to request
 * a specific list of related resources that the server should return,
 * along with the specific set of attributes on your main resource and the related resources.
 *
 * @param bareURL The undecorated URL to which you wish to append the inclusion and sparse fieldset query parameters.
 * This URL can include other query parameters already, for instance "/articles?page[count]=10".
 *
 * @param includes The list of related resources which you want the server to return along with the primary requested resource.
 * E.g. `GET /article` may request ["author","comments"]
 * @see http://jsonapi.org/format/#fetching-includes JSON:API docs on Inclusion of Related Resources.
 *
 * @param fields A dictionary mapping resource type strings to the list of attributes
 * which you want the server to return for that resource.
 * E.g. `GET /article` may request {"article": ["title", "published_at"], "author": ["name", "email"]}.
 * @see http://jsonapi.org/format/#fetching-sparse-fieldsets JSON:API docs on Sparse Fieldsets
 */
+ (NSString *)specifiedURLForBareURL:(NSString *)bareURL
                        withIncludes:(NSArray *)includes
                           andFields:(NSDictionary *)fields;

@end
