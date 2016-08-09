//
//  ResourceMainPageRequest.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/1.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "ResourceMainPageRequest.h"

@implementation ResourceMainPageRequest

//请求source界面的数据
+(void)requestResourceMainPageData{
    NSString* url = [NSString stringWithFormat:@"resource"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_RESOURCE_MAINPAGE_DATA];
    
    [request sendRequest];
}

@end
