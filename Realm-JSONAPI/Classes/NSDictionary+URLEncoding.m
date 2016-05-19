#import "NSDictionary+URLEncoding.h"

static NSString *fullyURLEncodeString(NSString *string) {
  return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"$&+,/:;=?@ \t#<>\"\n!*'()%[]", kCFStringEncodingUTF8));
}

// helper function: get the string form of any object
static NSString *toString(id object) {
  NSString *unencodedString = nil;
  if ([object isKindOfClass:[NSDictionary class]] || [object isKindOfClass:[NSArray class]]) {

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0
                                                         error:NULL];
    unencodedString = [[NSString alloc] initWithData:jsonData
                                            encoding:NSUTF8StringEncoding];
  } else {
    unencodedString = [NSString stringWithFormat:@"%@",
                       object];
  }
  return fullyURLEncodeString(unencodedString);
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
  NSString *string = toString(object);
  return string;
}

@implementation NSDictionary (URLEncoding)

- (NSString *)urlEncodedString
{
  NSMutableArray *parts = [NSMutableArray array];
  for (id key in self) {
    id value = self[key];
    NSString *part = [NSString stringWithFormat:@"%@=%@",
                      urlEncode([NSString stringWithFormat:@"%@", key]),
                      urlEncode(value)];
    [parts addObject:part];
  }
  return [parts componentsJoinedByString:@"&"];
}

@end