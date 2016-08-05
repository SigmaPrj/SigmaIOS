//
//  SAEInfoNewsRequest.h
//  Sigma
//
//  Created by Terence on 16/8/3.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SARequestBase.h"

@interface SAEInfoNewsRequest : SARequestBase

// 请求资讯
+(void)requestEInfoNews:(int)typeNum;

@end
