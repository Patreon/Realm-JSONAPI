#import "Comment.h"

@implementation Comment

+ (NSDictionary *)JSONtoModelMap {
  return @{
           @"id": @"uid",
           @"body": @"body",
           @"author": @"author",
           };
}

+ (NSArray *)defaultAttributes {
  return @[@"body"];
}

+ (NSArray *)defaultRelationships {
  return @[@"author"];
}

+ (NSString *)primaryKey {
  return @"uid";
}

@end
