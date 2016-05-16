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
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:@"articles" toClass:[Article class]];
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:@"people" toClass:[Person class]];
  [[JSONAPIResourceRegistry sharedInstance] bindJSONType:@"comments" toClass:[Comment class]];
}

- (void)setupRealm {
  RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
  BOOL isTesting = [[[NSProcessInfo processInfo] environment] objectForKey:@"XCInjectBundle"];
  if (isTesting) {
    config.inMemoryIdentifier = @"inMemoryRealm";
  } else {
    config.schemaVersion = 1; // swap with the below to persist to disk
  }
  [RLMRealmConfiguration setDefaultConfiguration:config];
}

@end
