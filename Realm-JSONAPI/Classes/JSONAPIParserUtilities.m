#import "JSONAPIParserUtilities.h"
#import "JSONAPIResourceRegistry.h"
#import "RLMObject+JSONAPIParser.h"
#import "RLMObjectWithSubclass.h"

@implementation JSONAPIParserUtilities

+ (id)putJSON:(NSDictionary<NSString *, id> *)json
      inRealm:(RLMRealm *)realm
{
  [realm beginWriteTransaction];
  id response = [self constructObjectWithJSON:json[@"data"]
                                      inRealm:realm];
  for (id obj in json[@"included"]) {
    [self constructObjectWithJSON:obj
                          inRealm:realm];
  }
  [realm commitWriteTransaction];

  return response;
}

+ (id)constructObjectWithJSON:(id)json
                      inRealm:(RLMRealm *)realm
{
  if ([json isKindOfClass:[NSDictionary class]]) {
    Class cls = [JSONAPIResourceRegistry.sharedInstance classForJSONTypeString:json[@"type"]];
    if ([cls conformsToProtocol:@protocol(RLMObjectWithSubclass)]) {
      cls = [((id<RLMObjectWithSubclass>)cls) subclassForJSON:json];
    }
    if (cls) {
      return [cls createOrUpdateInRealm:realm
                              withValue:[cls mapJSONToModel:json
                                                  withRealm:realm]];
    }
  } else if ([json isKindOfClass:[NSArray class]]) {
    NSArray *jsonArray = (NSArray *)json;
    NSMutableArray *results = [NSMutableArray array];
    for (id jsonObject in jsonArray) {
      id nativeObject = [self constructObjectWithJSON:jsonObject
                                              inRealm:realm];
      if (nativeObject) {
        [results addObject:nativeObject];
      }
    }
    return results;
  }

  NSLog(@"DEBUG: Failed to parse json %@.", json);
  return nil;
}

@end
