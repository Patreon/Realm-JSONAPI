// Inspired by http://blog.ablepear.com/2008/12/urlencoding-category-for-nsdictionary.html
#import <Foundation/Foundation.h>

/**
 * Transform a dictionary of keys and values into a query parameter string worthy of appending to any URL.
 */
@interface NSDictionary (URLEncoding)

/**
 * @return An NSString which is a URL encoded version of
 * the current NSDictionary as if it were query parameters.
 * E.g. {"include": "comments", "page[size]": 10} => "include=comments&page%5Bsize%5D=10"
 */
- (NSString *)urlEncodedString;

@end
