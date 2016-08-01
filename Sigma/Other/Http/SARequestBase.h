//
// Created by 汤轶侬 on 16/7/25.
// Copyright (c) 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SACommunityRequestType) {
    FIRST_REQUEST=0,
    LOAD_NEW_REQUEST=1,
    LOAD_MORE_REQUEST=2
};

@interface SARequestBase : NSObject

/*!
 *
 * 获取请求对象
 *
 * @param path 请求路径 例如:想获取所有activity 值就是 @"activity"
 * @param method 请求方法, GET, POST, PUT, DELETE
 * @param dict 请求参数, 为GET请求时, 参数在url中; POST请求时, 参数放在请求体中。 如
 *              @{@"t": @1234567} 现在支持参数有 p:<:int>分页 t:<:int>时间戳 state:<:string>hot
 * @param token 登录之后会获取到一个token, 有些数据需要token才可访问。 该参数大部分时候不需要。给空就行
 * @param notificationName 通知名称 必填 每一个请求需要有自己特有的通知名称,用于在收到数据后发通知
 *
 * @return
 */
+ (instancetype)requestWithPath:(NSString *)path
                           method:(NSString *)method
                       parameters:(NSDictionary *)dict
                            token:(NSString *)token
                     notification:(NSString *)notificationName;

/*!
 *
 * 方法同上
 *
 */
- (instancetype)initWithPath:(NSString *)path
                      method:(NSString *)method
                  parameters:(NSDictionary *)dict
                       token:(NSString *)token
                notification:(NSString *)notificationName;

/**
 * @param notificationName 这是最后一次可以修改通知名称的地方
 */
- (void)sendRequest:(NSString *)notificationName;

/**
 * 如果你前面已经设定了通知名称, 你可以直接通过这个方法进行请求
 */
- (void)sendRequest;

@end