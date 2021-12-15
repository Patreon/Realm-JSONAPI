#import <Foundation/Foundation.h>

/**
 * A two-way lookup for JSON:API type strings and their corresponding RLMObject classes.
 * You should use bindJSONType:toClass: as early as possible in your application's lifecycle,
 * certainly before you do any serialization or parsing,
 * as those processes use this registry to look up the appropriate classes to use for their work.
 */
@interface JSONAPIResourceRegistry : NSObject

/**
 * @return a JSONAPIResourceRegistry in which you can register your RLMObjects
 */
@property (class, nonatomic, readonly) JSONAPIResourceRegistry *sharedInstance;

/**
 * Register a binding between a given resource type string
 * and the RLMObject that is used to represent resources of that type.
 * Should be done early in the application's lifecycle,
 * before any of this libary's parsing or serializing methods are used.
 *
 * @param jsonType The string which the API uses to identify a particular type of resource.
 *
 * @param cls The Class, a subclass of RLMObject,
 * which will be used to represent resources matching the jsonType type string.
 */
- (void)bindJSONType:(NSString *)jsonType toClass:(Class)cls;

/**
 * Retrieve the type string which was previously bound to the given class.
 *
 * @param cls The Class, a subclass of RLMObject,
 * which is used to represent resources matching the desired type string.
 *
 * @return An NSString which was bound to the given Class via a prior call to `bindJSONType:toClass:`.
 * It is used to indicate to the server which API resources we are referring to,
 * or to understand which API resources the server has sent to us.
 */
- (NSString *)jsonTypeStringForClass:(Class)cls;

/**
 * Retrieve the class which was previously bound to the given type string.
 *
 * @param typeString The NSString which is used to indicate to the server
 * which API resources we are referring to,
 * or to understand which API resources the server has sent to us.
 *
 * @return A Class, specifically a subclass of RLMObject, which was bound to the given type string
 * via a prior call to `bindJSONType:toClass:`.
 * It is used to represent resources matching the desired type string.
 */
- (Class)classForJSONTypeString:(NSString *)typeString;

@end
