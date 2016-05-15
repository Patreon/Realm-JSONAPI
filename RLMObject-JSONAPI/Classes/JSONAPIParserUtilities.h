#import <Foundation/Foundation.h>
#import <Realm/RLMRealm.h>

@interface JSONAPIParserUtilities : NSObject

// returns the RLMObject corresponding to json[@"data"]
// parses (but does not return) json[@"included"]
+ (id)putJSON:(NSDictionary *)json
      inRealm:(RLMRealm *)realm;

@end
