#import <Realm/Realm.h>

@interface Person : RLMObject
@property (nonnull) NSString *uid;
@property (nullable) NSString *firstName;
@property (nullable) NSString *lastName;
@property (nullable) NSString *twitterHandle;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Person>
RLM_ARRAY_TYPE(Person)
