# Realm-JSONAPI

[![CI Status](https://circleci.com/gh/Patreon/Realm-JSONAPI.svg?style=shield&circle-token=2b02da6debbb70cf4841a3b40d39202baef2deb7)](https://circleci.com/gh/Patreon/Realm-JSONAPI)
[![Version](https://img.shields.io/cocoapods/v/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)
[![License](https://img.shields.io/cocoapods/l/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)
[![Platform](https://img.shields.io/cocoapods/p/Realm-JSONAPI.svg?style=flat)](http://cocoapods.org/pods/Realm-JSONAPI)

Easily integrate your [Realm](http://realm.io) models with a [JSON:API](http://jsonapi.org) compliant server

## Table of Contents

1. [Usage](#usage)
2. [Example](#example)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Author](#author)
6. [License](#license)


## Usage

1. Define a [Realm](http://realm.io) model
2. `#import <Realm_JSONAPI/RLMObject+JSONAPI.h>`
3. Define `JSONtoModelMap` (and we recommend `defaultAttributes` and `defaultRelationships` as well)
4. Register the model early in the application's lifecycle via `[[JSONAPIResourceRegistry sharedInstance] bindJSONType:@"your-model-type" toClass:[Model class]]`
5. Parse server responses with `[JSONAPIParserUtilities putJSON:serverResponseDict inRealm:[RLMRealm defaultRealm]]`
6. Serialize your model to JSON with `[model toJSON]` and send it to the server


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
