#import <Foundation/Foundation.h>

@protocol RLMObjectWithSubclass <NSObject>

+ (Class)subclassForJSON:(id)json;

@end
