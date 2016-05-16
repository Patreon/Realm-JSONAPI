#import "Article.h"
#import <Realm_JSONAPI/RLMObject+JSONAPI.h>

@implementation Article

+ (NSDictionary *)JSONtoModelMap {
  return @{
           @"id": @"uid",
           @"title": @"title",
           @"author": @"author",
           @"comments": @"comments"
           };
}

+ (NSArray *)defaultAttributes {
  return @[@"title"];
}

+ (NSArray *)defaultRelationships {
  return @[@"author", @"comments"];
}

+ (NSString *)primaryKey {
  return @"uid";
}

@end
