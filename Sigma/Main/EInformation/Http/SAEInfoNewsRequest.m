//
//  SAEInfoNewsRequest.m
//  Sigma
//
//  Created by Terence on 16/8/3.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAEInfoNewsRequest.h"

@implementation SAEInfoNewsRequest

+(void)requestEInfoNews:(int)typeNum{
    NSString* url = [NSString stringWithFormat:@"newstype/%d/news", typeNum];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_EINFORMATION_NEWSDETAIL];
    
    [request sendRequest];
}

@end
