# Realm-JSONAPI

[![CI Status](http://img.shields.io/travis/Patreon/Realm-JSONAPI.svg?style=flat)](https://travis-ci.org/Patreon/Realm-JSONAPI)
[![Version](https://img.shields.io/cocoapods/v/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)
[![License](https://img.shields.io/cocoapods/l/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)
[![Platform](https://img.shields.io/cocoapods/p/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objective-c
#import <Realm_JSONAPI/RLMObject+JSONAPI.h>

@interface User : RLMModel
@property NSString *uid;
@property NSString *name;
@property NSString *email;
@property NSString *avatarURL;
@end

@implementation User

+ (NSDictionary *)JSONtoModelMap {
    return @{
        @"id" : @"uid",
        @"full_name" : @"fullName",
        @"email" : @"email",
        @"image_url": @"avatarURL",
    };
}

+ (NSArray *)defaultRelationships {
    return @[];
}

+ (NSArray *)defaultAttributes {
    return @[
        @"full_name",
        @"email",
        @"image_url",
    ];
}

+ (NSString *)primaryKey {
    return @"uid";
}

+ (void)fetchUser:(NSString *)uid {
    NSString *baseURL = [NSString stringWithFormat:@"users/%@", uid];
    [APICall queueWithURL:[[self class] defaultURLDecoration:baseURL]
                   params:[self toJSON]
                   method:HttpMethodGET
              andCallback:callback];
}

- (void)postWithCallback:(APICompletionBlock)callback {
    NSString *baseURL = [NSString stringWithFormat:@"users/%@", self.uid];
    [APICall queueWithURL:[[self class] defaultURLDecoration:baseURL]
                   params:[self toJSON]
                   method:HttpMethodPATCH
              andCallback:callback];
}
```

## Requirements

[Realm](http://realm.io) and a [JSON:API](http://jsonapi.org)-compliant server

## Installation

Realm-JSONAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Realm-JSONAPI"
```

## Author

David Kettler, david@patreon.com

## License

Realm-JSONAPI is available under the Apache 2.0 license. See the LICENSE file for more info.
