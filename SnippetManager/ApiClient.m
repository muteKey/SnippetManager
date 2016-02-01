//
//  ApiClient.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "ApiClient.h"
#import <AFHTTPSessionManager.h>

@interface ApiClient ()

@property (nonatomic, strong) AFHTTPSessionManager *apiManager;

@end

#define BASE_URL @"https://ios-snippet.restdb.io/"
#define API_KEY @"dfb400eec7bdf05607e80177f0eab141c56f4"

@implementation ApiClient

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.apiManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]
                                                   sessionConfiguration:nil];
        [self.apiManager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"x-apikey"];
        
    }
    return self;
}

- (NSURLSessionTask*)snippetsWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.apiManager GET:@"rest/snippet"
                     parameters:nil
                       progress:nil
                        success:success
                        failure:failure];
}

- (NSURLSessionTask*)mediaWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.apiManager GET:@"media/56af74232d354d5200001a50"
                     parameters:nil
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"object %@", responseObject);

                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"error %@", error);

                        }];
}


@end
