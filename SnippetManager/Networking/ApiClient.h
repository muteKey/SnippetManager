//
//  ApiClient.h
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiClientProtocol <NSObject>

- (NSURLSessionTask*)snippetsWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionTask*)mediaWithID:(NSString*)identifier
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

@interface ApiClient : NSObject <ApiClientProtocol>

+ (instancetype)sharedInstance;

@end
