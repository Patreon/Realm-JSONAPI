#import <Realm/Realm.h>

@interface RLMObject (JSONAPIURL)

+ (NSDictionary *)defaultAttributesAsFieldsDictionary;
+ (NSDictionary *)fieldsIncludingRelationships:(NSArray *)relationships;
+ (NSString *)defaultURLDecoration:(NSString *)bareURL;

@end
