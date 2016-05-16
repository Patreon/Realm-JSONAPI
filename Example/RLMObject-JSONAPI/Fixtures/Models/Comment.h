#import <Realm/Realm.h>

@class Person;

@interface Comment : RLMObject
@property (nonnull) NSString *uid;
@property (nullable) NSString *body;
@property (nullable) Person *author;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Comment>
RLM_ARRAY_TYPE(Comment)
