#import <Foundation/Foundation.h>

/**
 * A class that makes it very easy to move between NSDates and ISO8601-formatted strings.
 * Uses strptime and strftime under the hood for performance gains.
 */
@interface NSDate (ISO8601)

/**
 * @return An NSDate instance matching an [ISO8601](https://en.wikipedia.org/wiki/ISO_8601)-formatted string.
 * Corresponds to a NSDateFormatter formatString of "yyyy-MM-dd'T'HH:mm:ssZ",
 * but the implementation here uses strptime in C directly for big speed wins.
 */
+ (NSDate *)dateFromISO8601String:(NSString *)string;

/**
 * @return an NSString representing the current NSDate as an [ISO8601](https://en.wikipedia.org/wiki/ISO_8601)-formatted string.
 * Corresponds to a NSDateFormatter formatString of "yyyy-MM-dd'T'HH:mm:ssZ"
 * but the implementation here uses strftime in C directly for big speed wins.
 */
- (NSString *)ISO8601String;

// TODO:
//+ (NSDate *)dateFromISO8601MillisString:(NSString *)string;
//- (NSString *)ISO8601MillisString;

@end
