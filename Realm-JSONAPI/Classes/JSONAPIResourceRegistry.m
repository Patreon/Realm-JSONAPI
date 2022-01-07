#import "JSONAPIResourceRegistry.h"

@interface JSONAPIResourceRegistry ()
@property (nonatomic, strong) NSMutableDictionary *classMap;
@end

@implementation JSONAPIResourceRegistry

+ (JSONAPIResourceRegistry *)sharedInstance {
  static JSONAPIResourceRegistry *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[JSONAPIResourceRegistry alloc] init];
  });
  return sharedInstance;
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

- (nullable NSString *)jsonTypeStringForClass:(Class)cls {
  return [[self.classMap allKeysForObject:cls] firstObject];
}

- (nullable Class)classForJSONTypeString:(NSString *)typeString {
  return self.classMap[typeString];
}

@end
