#import "JSONAPIResourceRegistry.h"

@interface JSONAPIResourceRegistry ()
@property (nonatomic, strong) NSMutableDictionary *classMap;
@end

@implementation JSONAPIResourceRegistry

static JSONAPIResourceRegistry *JSONAPIResourceRegistrySharedInstance = nil;

+ (JSONAPIResourceRegistry *)sharedInstance {
  if (!JSONAPIResourceRegistrySharedInstance) {
    @synchronized(self) {
      JSONAPIResourceRegistrySharedInstance = [super allocWithZone:NULL];
      JSONAPIResourceRegistrySharedInstance = [JSONAPIResourceRegistrySharedInstance init];
    }
  }
  return JSONAPIResourceRegistrySharedInstance;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.classMap = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)bindJSONType:(NSString *)jsonType toClass:(Class)cls {
  self.classMap[jsonType] = cls;
}

- (NSString *)jsonTypeStringForClass:(Class)cls {
  return [[self.classMap allKeysForObject:cls] firstObject];
}

- (Class)classForJSONTypeString:(NSString *)typeString {
  return self.classMap[typeString];
}

@end
