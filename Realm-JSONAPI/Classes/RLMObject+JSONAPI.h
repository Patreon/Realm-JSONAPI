#import <Realm/Realm.h>
#import "RLMObject+JSONAPIResource.h"
#import "RLMObject+JSONAPIParser.h"
#import "RLMObject+JSONAPISerializer.h"
#import "RLMObject+JSONAPIURL.h"

/**
 * *The* file to import to get most all of the Realm-JSONAPI tools.
 *
 * @see RLMObject+JSONAPIResource.h to read more about how to give an RLMObject
 * sufficient metadata to interact well with the serialization and deserialization procedures.
 * @see RLMObject+JSONAPIParser.h to read more about the actual parsing mechanics.
 * @see RLMObject+JSONAPISerializer.h to read more about the actual serialization mechanics.
 * @see RLMObject+JSONAPIURL.h to read more about how to decorate a JSON:API-compliant URL with
 * included resource and sparse fieldset query parameters.
 */
@interface RLMObject (JSONAPI)

@end
