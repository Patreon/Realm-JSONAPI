#import <Realm/Realm.h>
#import "Comment.h"

@class Person;

@interface Article : RLMObject
@property (nonnull) NSString *uid;
@property (nullable) NSString *title;
@property (nullable) Person *author;
@property (nullable) RLMArray<Comment> *comments;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Article>
RLM_ARRAY_TYPE(Article)
