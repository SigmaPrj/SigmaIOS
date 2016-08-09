//
//  CourseMainPageRequest.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/5.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "CourseMainPageRequest.h"

@implementation CourseMainPageRequest

//请求course主界面的cell的数据
+(void)requestCourseMainPageData{
    NSString* url = [NSString stringWithFormat:@"video"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:COURSE_MAINPAGE_DATA];
    
    [request sendRequest];
}

@end
