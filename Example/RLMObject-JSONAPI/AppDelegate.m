#import "AppDelegate.h"

#import <RLMObject_JSONAPI/RLMObject+JSONAPI.h>
#import <RLMObject_JSONAPI/JSONAPIResourceRegistry.h>

#import "Fixtures.h"
#import "ArticleListController.h"
#import "Article.h"
#import "Person.h"
#import "Comment.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  [self registerResources];

  [self setupRealm];
  [Fixtures loadFixtures];

  self.window.rootViewController = [[UINavigationController alloc]
                                    initWithRootViewController:[ArticleListController new]];
  [self.window makeKeyAndVisible];

  return YES;
}

- (void)registerResources {
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:[Article type] toClass:[Article class]];
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:[Person type] toClass:[Person class]];
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:[Comment type] toClass:[Comment class]];
}

- (void)setupRealm {
  BOOL isTesting = [[[NSProcessInfo processInfo] arguments] containsObject:@"-XCTest"];
  if (isTesting) {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"test.realm"];
    [[NSFileManager defaultManager] createFileAtPath:filePath
                                            contents:[NSData data]
                                          attributes:nil];
    RLMRealmConfiguration *conf = [RLMRealmConfiguration defaultConfiguration];
    conf.fileURL = [NSURL URLWithString:filePath];
    [RLMRealmConfiguration setDefaultConfiguration:conf];
  }
}

@end
