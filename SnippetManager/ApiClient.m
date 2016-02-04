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
@property (nonatomic, strong) AFHTTPSessionManager *mediaManager;

@end

#define BASE_REST_URL @"https://ios-snippet.restdb.io/rest"
#define BASE_MEDIA_URL @"https://ios-snippet.restdb.io/media"

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
        self.apiManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_REST_URL]
                                                   sessionConfiguration:nil];
        [self.apiManager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"x-apikey"];
        
        self.mediaManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_MEDIA_URL]
                                                     sessionConfiguration:nil];
        [self.mediaManager.requestSerializer setValue:API_KEY forHTTPHeaderField:@"x-apikey"];
        self.mediaManager.responseSerializer = [AFXMLDocumentResponseSerializer serializer];
    }
    return self;
}

- (NSURLSessionTask*)snippetsWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.apiManager GET:@"snippet"
                     parameters:nil
                       progress:nil
                        success:success
                        failure:failure];
}

- (NSURLSessionTask*)mediaWithID:(NSString*)identifier
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.mediaManager GET:identifier
                       parameters:nil
                         progress:nil
                          success:success
                          failure:failure];
}


@end
