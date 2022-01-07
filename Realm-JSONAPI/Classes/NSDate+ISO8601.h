#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A class that makes it very easy to move between NSDates and ISO8601-formatted strings.
 * Uses strptime and strftime from C's time.h lib under the hood for performance gains.
 */
@interface NSDate (ISO8601)

/**
 * @return An NSDate instance matching an ISO8601-formatted string.
 * Corresponds to a NSDateFormatter formatString of "yyyy-MM-dd'T'HH:mm:ssZ",
 * but the implementation here uses strptime in C directly for big speed wins.
 *
 * @see https://en.wikipedia.org/wiki/ISO_8601
 */
+ (nullable NSDate *)dateFromISO8601String:(nullable NSString *)string;

/**
 * @return an NSString representing the current NSDate as an ISO8601-formatted string.
 * Corresponds to a NSDateFormatter formatString of "yyyy-MM-dd'T'HH:mm:ssZ"
 * but the implementation here uses strftime in C directly for big speed wins.
 *
 * @see https://en.wikipedia.org/wiki/ISO_8601
 */
- (NSString *)ISO8601String;

// TODO:
//+ (NSDate *)dateFromISO8601MillisString:(NSString *)string;
//- (NSString *)ISO8601MillisString;

@end

NS_ASSUME_NONNULL_END
