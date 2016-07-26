//
//  SADateHelper.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/25.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SADateHelper : NSObject

/*!
 * 将日期时间人性化
 *  人性化规则
 *      为当天 :   显示  HH:mm
 *      为昨天 :   显示  昨天 HH:mm
 *      为当年 :   显示  mm月dd日
 *      为其他年:  显示  YYYY年mm月dd日
 *
 * @param time
 * @return
 */
+ (NSString *)humanizedDate:(NSTimeInterval)time;

@end
