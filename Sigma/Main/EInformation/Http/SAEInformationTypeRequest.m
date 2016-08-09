//
//  SAEInformationTypeRequest.m
//  Sigma
//
//  Created by Terence on 16/8/2.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAEInformationTypeRequest.h"

@implementation SAEInformationTypeRequest

+ (void) requestEInfoType{
    NSString* url = [NSString stringWithFormat:@"newstype"];
    
    SARequestBase* request = [self requestWithPath:url method:@"GET" parameters:nil token:nil notification:NOTI_EINFORMATION_NEWSTYPE];
    
    [request sendRequest];
}

@end
