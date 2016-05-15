#import <Foundation/Foundation.h>

@interface NSDate (ISO8601)

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;

// TODO:
//+ (NSDate *)dateFromISO8601MillisString:(NSString *)string;
//- (NSString *)ISO8601MillisString;

@end
