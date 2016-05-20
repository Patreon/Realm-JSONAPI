#import <Realm/Realm.h>

/**
 * This category handles decorating URLs with standard JSON:API query parameters.
 * In most cases, you should override `defaultAttributes` and `defaultRelationships`
 * to specify what your app expects to receive from the server in most cases.
 * Then, you can use `defaultURLDecoration:` to decorate a URL with the query parameters
 * needed to specify those desired attributes and relationships to the server.
 *
 * By explicitly requesting what you want, you make the server not have to guess.
 * This makes versioning a breeze, as it allows your server to change its defaults without breaking clients.
 *
 * If you want to break out of your defaults, you can use `fieldsIncludingRelationships:`
 * and modify its contents, then use `JSONAPIURLUtilities` to decorate your URL more manually.
 *
 * @see JSONAPIURLUtilities
 */
@interface RLMObject (JSONAPIURL)

/**
 * These attributes are converted, along with the relationships in defaultRelationships, into
 * sparse fieldset and included resource query parameters and appended as query parameters to API request URLs.
 * By specifying the attributes you wish to request,
 * it allows your server to change its defaults without breaking clients.
 * By explicitly requesting what you want, you make the server not have to guess.
 *
 * @return An NSArray that lists the attributes which you wish to request by default from the server
 *
 * @see +defaultURLDecoration:
 * @see +defaultAttributesAsFieldsDictionary
 * @see [http://jsonapi.org/format#fetching-sparse-fieldsets](http://jsonapi.org/format#fetching-sparse-fieldsets) JSON:API docs on Sparse Fieldsets
 */
+ (NSArray *)defaultAttributes;

/**
 * These relationships are converted, along with the attributes in defaultAttributes, into
 * sparse fieldset and included resource query parameters and appended as query parameters to API request URLs.
 * By specifying the attributes you wish to request,
 * it allows your server to change its defaults without breaking clients.
 * By explicitly requesting what you want, you make the server not have to guess.
 *
 * @return An NSArray that lists the relationships which you wish to request by default from the server
 *
 * @see +defaultURLDecoration:
 * @see [http://jsonapi.org/format#fetching-includes](http://jsonapi.org/format#fetching-includes) JSON:API docs on Inclusion of Related Resources
 */
+ (NSArray *)defaultRelationships;

/**
 * Turns the defaultAttributes and defaultRelationships of this object into
 * sparse fieldset and included resource query parameters,
 * and appends those query parameters to the provided string.
 * You should use this method (or JSONAPIURLUtilities, which this method uses under the hood)
 * on all of your API requests, as it allows your server to change its defaults without breaking clients.
 * By explicitly requesting what you want, you make the server not have to guess.
 *
 * @param bareURL The URL to which you wish to append the sparse fieldset and included resource query parameters
 *
 * @return An NSString created by joining the bare URL
 * with the sparse fieldset and included resource query parameters.
 *
 * @see [JSONAPIURLUtilities specifiedURLForBareURL:withIncludes:andFields:]
 * @see [http://jsonapi.org/format#fetching-includes](http://jsonapi.org/format#fetching-includes) JSON:API docs on Inclusion of Related Resources.
 * @see [http://jsonapi.org/format#fetching-sparse-fieldsets](http://jsonapi.org/format#fetching-sparse-fieldsets) JSON:API docs on Sparse Fieldsets
 */
+ (NSString *)defaultURLDecoration:(NSString *)bareURL;

/**
 * Useful if you wish to modify the query parameters instead of using the defaultURLDecoration method directly.
 *
 * @return This class's defaultAttributes NSArray as the value in a dictionary where this class's type is the key.
 */
+ (NSDictionary *)defaultAttributesAsFieldsDictionary;

/**
 * Useful if you wish to modify the query parameters instead of using the defaultURLDecoration method directly.
 *
 * @param relationships A list of the relationships for which you want to specify your desired fields.
 * Can be dot-separated paths, as per the JSON:API spec's discussion of include query parameter values.
 *
 * @return This class's defaultAttributes NSArray as the value in a dictionary where this class's type is the key,
 * along with each of the related class's defaultAttributes as values corresponding to their types as keys.
 */
+ (NSDictionary *)fieldsIncludingRelationships:(NSArray *)relationships;

@end
