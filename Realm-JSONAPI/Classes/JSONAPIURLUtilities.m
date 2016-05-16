#import "JSONAPIURLUtilities.h"
#import "NSDictionary+URLEncoding.h"

@implementation JSONAPIURLUtilities

+ (NSString *)getJoinedOrNull:(NSArray *)arr {
  if (arr.count == 0) {
    return @"null";
  } else {
    return [arr componentsJoinedByString:@","];
  }
}

+ (NSString *)getStringIncludes:(NSArray *)includes {
  return [self getJoinedOrNull:includes];
}

+ (NSDictionary *)getStringFields:(NSDictionary *)fields {
  NSMutableDictionary *stringFields = [NSMutableDictionary dictionaryWithCapacity:fields.count];
  for (NSString *key in fields) {
    stringFields[[NSString stringWithFormat:@"fields[%@]", key]] = [self getJoinedOrNull:fields[key]];
  }
  return stringFields;
}

+ (NSString *)specifiedURLForBareURL:(NSString *)bareURL
                        withIncludes:(NSArray *)includes
                           andFields:(NSDictionary *)fields
{
  NSString *connector = @"?";
  if ([bareURL rangeOfString:@"?"].location != NSNotFound) {
    connector = @"&";
  }
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:(fields.count + 1)];
  if (includes != nil) {
    params[@"include"] = [self getStringIncludes:includes];
  }
  if (fields != nil) {
    [params addEntriesFromDictionary:[self getStringFields:fields]];
  }
  NSString *newQueryParams = [params urlEncodedString];
  return [[bareURL stringByAppendingString:connector] stringByAppendingString:newQueryParams];
}

@end
