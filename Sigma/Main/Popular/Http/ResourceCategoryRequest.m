//
//  ResourceCategoryRequest.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/3.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "ResourceCategoryRequest.h"

@implementation ResourceCategoryRequest

//请求category界面的数据
+(void)requestCategoryOfResourceData{
    NSString* url = [NSString stringWithFormat:@"category"];
    
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:CATEGORY_PAGE_DATA];
    
    [request sendRequest];
    
}

@end
