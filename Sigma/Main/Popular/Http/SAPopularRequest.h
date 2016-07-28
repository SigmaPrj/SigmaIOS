//
//  SAPopularRequest.h
//  Sigma
//
//  Created by Terence on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SARequestBase.h"

@interface SAPopularRequest : SARequestBase


// 请求热门问答
+ (void) requestQuestionData;

// 请求热门课程
+ (void) requestVideoData;

// 请求热门资源
+ (void) requestResourceData;


@end
