#import <Foundation/Foundation.h>

@interface JSONAPIURLUtilities : NSObject

+ (NSString *)specifiedURLForBareURL:(NSString *)bareURL
                        withIncludes:(NSArray *)includes
                           andFields:(NSDictionary *)fields;

@end
