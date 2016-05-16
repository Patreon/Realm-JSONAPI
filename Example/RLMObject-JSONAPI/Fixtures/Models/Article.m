#import "Article.h"
#import <RLMObject_JSONAPI/RLMObject+JSONAPI.h>

@implementation Article

+ (NSString *)type {
  return @"articles";
}

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
