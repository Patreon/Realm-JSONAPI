#import <Foundation/Foundation.h>

@interface JSONAPIResourceRegistry : NSObject

+ (JSONAPIResourceRegistry *)sharedInstance;

- (void)bindJSONType:(NSString *)jsonType toClass:(Class)cls;
- (NSString *)jsonTypeStringForClass:(Class)cls;
- (Class)classForJSONTypeString:(NSString *)typeString;

@end
