#import <Realm/Realm.h>

@interface RLMObject (JSONAPISerializer)

// returns just the object data
- (NSDictionary *)toJSON;
// returns a dictionary containing the object (under @"data") and the included related types (under @"included")
- (NSDictionary *)toJSONWithIncludedTypes:(NSSet *)types;

@end
