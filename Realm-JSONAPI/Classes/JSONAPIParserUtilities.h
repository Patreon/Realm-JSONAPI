#import <Foundation/Foundation.h>
#import <Realm/RLMRealm.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The primary entry point for parsing server responses.
 * Takes in a server response, and puts the corresponding objects in the realm
 */
@interface JSONAPIParserUtilities : NSObject

/**
 * Parses a JSON:API-compliant server response into a RLMRealm, committing the transaction.
 * Returns the RLMObject corresponding to json[@"data"],
 * and parses but does not return json[@"included"]
 *
 * @param json A JSON:API-compliant server response.
 * Has at least a "data" top-level key.
 * Optionally has an "included" top-level key, which will be parsed into the realm but not returned.
 *
 * @param realm the RLMRealm into which you wish to parse the server response
 *
 * @return an RLMObject representing the json[@"data"] data.
 */
+ (nullable id)putJSON:(NSDictionary<NSString *, id> *)json
               inRealm:(RLMRealm *)realm;

@end

NS_ASSUME_NONNULL_END
