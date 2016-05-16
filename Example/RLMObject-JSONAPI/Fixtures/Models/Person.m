#import "Person.h"

@implementation Person

+ (NSDictionary *)JSONtoModelMap {
  return @{
           @"id": @"uid",
           @"first-name": @"firstName",
           @"last-name": @"lastName",
           @"twitter": @"twitterHandle"
           };
}

+ (NSArray *)defaultAttributes {
  return @[@"first-name", @"last-name", @"twitter"];
}

+ (NSArray *)defaultRelationships {
  return @[];
}

+ (NSString *)primaryKey {
  return @"uid";
}

@end
