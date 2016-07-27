//
// Created by 汤轶侬 on 16/7/25.
// Copyright (c) 2016 Terence. All rights reserved.
//

#import "SARequestBase.h"
#import "AFURLSessionManager.h"

#import "AFNetworking.h"

@interface SARequestBase()

@property (nonatomic, strong) AFURLSessionManager* manager;
@property (nonatomic, strong) AFHTTPRequestSerializer *requestSerializer;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, copy) NSString *notificationName;

@end

@implementation SARequestBase

- (instancetype)initWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)dict token:(NSString *)token notification:(NSString *)noti {
    self = [super init];
    if (self) {
        // 参数
        _notificationName = noti;
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 5;
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        // 设置HTTP头
        [_requestSerializer setValue:SIGMA_API_VALUE forHTTPHeaderField:SIGMA_API_NAME];
        if (token) {
            [_requestSerializer setValue:token forHTTPHeaderField:SIGMA_TOKEN_NAME];
        }
        // API URL
        NSString *apiUrl = [NSString stringWithFormat:@"%@%@", SIGMA_API_DOMAIN, path];
        _request = [_requestSerializer requestWithMethod:method URLString:apiUrl parameters:dict error:nil];
    }

    return self;
}

+ (instancetype)requestWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)dict token:(NSString *)token notification:(NSString *)noti{
    return [[self alloc] initWithPath:path method:method parameters:dict token:token notification:noti];
}

- (void)sendRequest {
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:_request completionHandler:^(NSURLResponse *response, id obj, NSError *err) {
        if (!err) {
            [[NSNotificationCenter defaultCenter] postNotificationName:_notificationName object:nil userInfo:obj];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:REQUEST_DATA_ERROR object:nil userInfo:obj];
        }
    }];

    [dataTask resume];
}

- (void)sendRequest:(NSString *)notificationName {
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:_request completionHandler:^(NSURLResponse *response, id obj, NSError *err) {
        if (!err) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@", obj);
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:obj];
            }
        } else {

        }
    }];

    [dataTask resume];
}

@end