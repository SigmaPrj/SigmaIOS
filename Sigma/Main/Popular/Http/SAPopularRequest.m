//
//  SAPopularRequest.m
//  Sigma
//
//  Created by Terence on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularRequest.h"

@implementation SAPopularRequest

// 请求热门问答
+ (void) requestQuestionData{
    NSString* url = [NSString stringWithFormat:@"question"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_POPULAR_QUESTION_DATA];
    
    [request sendRequest];
}

// 请求热门课程
+ (void) requestVideoData{
    NSString* url = [NSString stringWithFormat:@"video"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_POPULAR_VIDEO_DATA];
    
    [request sendRequest];
}

// 请求热门资源
+ (void) requestResourceData{
    NSString* url = [NSString stringWithFormat:@"resource"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_POPULAR_RESOURCE_DATA];
    
    [request sendRequest];
}

@end
