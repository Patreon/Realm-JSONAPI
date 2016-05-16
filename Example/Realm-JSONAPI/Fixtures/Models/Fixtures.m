#import "Fixtures.h"
#import <Realm/RLMRealmConfiguration.h>
#import <Realm_JSONAPI/JSONAPIParserUtilities.h>
#import "Article.h"
#import "Person.h"
#import "Comment.h"

@implementation Fixtures

+ (NSDictionary *)loadJSON
{
  NSBundle *mainBundle = [NSBundle mainBundle];
  NSString *filePath = [mainBundle pathForResource:@"canonical-fixutre.json"
                                            ofType:nil];
  NSLog(@"file path %@", filePath);
  NSMutableData *jsonData = [NSMutableData dataWithContentsOfFile:filePath];
  NSError *jsonParsingError = nil;
  return [NSJSONSerialization JSONObjectWithData:jsonData
                                         options:0 error:&jsonParsingError];
}

+ (void)loadFixtures
{
  NSDictionary *fixtures = [self loadJSON];

  [JSONAPIParserUtilities putJSON:fixtures
                          inRealm:[RLMRealm defaultRealm]];
}

@end
