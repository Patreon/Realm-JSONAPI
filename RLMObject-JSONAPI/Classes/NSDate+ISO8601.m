#import "NSDate+ISO8601.h"
#include <time.h>

@implementation NSDate (ISO8601)

+ (NSDate *)dateFromISO8601String:(NSString *)string {
  if (!string) {
    return nil;
  }

  struct tm tm;
  time_t t;

  strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
  tm.tm_isdst = -1;
  t = mktime(&tm);

  return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

- (NSString *)ISO8601String {
  struct tm *timeinfo;
  char buffer[80];

  time_t rawtime = [self timeIntervalSince1970] - [[NSTimeZone localTimeZone] secondsFromGMT];
  timeinfo = localtime(&rawtime);

  strftime(buffer, 80, "%Y-%m-%dT%H:%M:%S%z", timeinfo);

  return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}

@end
