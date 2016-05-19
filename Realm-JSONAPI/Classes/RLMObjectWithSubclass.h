#import <Foundation/Foundation.h>

/**
 * If you wish to parse one JSON:API resource type into more than one RLMObject type,
 * have a parent RLMObject class declare that it follows this protocol and implement the required method.
 */
@protocol RLMObjectWithSubclass <NSObject>

/**
 * @param json The inbound JSON:API Resource Object which you wish to parse into a subclass of this class.
 * @return The subclass of this class which should be used to represent the provided JSON:API Resource Object.
 */
+ (Class)subclassForJSON:(id)json;

@end
