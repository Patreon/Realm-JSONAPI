#import <Foundation/Foundation.h>

// From http://blog.ablepear.com/2008/12/urlencoding-category-for-nsdictionary.html but couldn't find a cocoapod for it
@interface NSDictionary (URLEncoding)

- (NSString *)urlEncodedString;
- (NSString *)urlEncodedString:(BOOL)preserveBrackets;

@end
