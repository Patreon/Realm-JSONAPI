#import <Foundation/Foundation.h>
#import <Realm/RLMRealm.h>

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
+ (id)putJSON:(NSDictionary *)json
      inRealm:(RLMRealm *)realm;

@end
