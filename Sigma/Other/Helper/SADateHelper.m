//
//  SADateHelper.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/25.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#import "SADateHelper.h"

@implementation SADateHelper

+ (NSString *)humanizedDate:(NSTimeInterval)time {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDate *now = [NSDate date];
    NSDateComponents *nowComponents = [calendar components:unitFlags fromDate:now];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];

    if ([nowComponents year] != [dateComponents year]) {
        // 显示 年 月 日u
        return [NSString stringWithFormat:@"%ld年%ld月%ld日", [dateComponents year], [dateComponents month], [dateComponents day]];
    } else if ([nowComponents month] != [dateComponents month]) {
        // 显示 月 日
        return [NSString stringWithFormat:@"%ld月%ld日", [dateComponents month], [dateComponents day]];
    } else if ([nowComponents day] == [dateComponents day]) {
        return [NSString stringWithFormat:@"%ld:%ld", (long)[dateComponents hour], (long)[dateComponents minute]];
    } else if ([nowComponents day] == ([dateComponents day]+1)) {
        return [NSString stringWithFormat:@"昨天 %ld:%ld", (long)[dateComponents hour], (long)[dateComponents minute]];
    } else {
        return [NSString stringWithFormat:@"%ld月%ld日", (long)[dateComponents month], (long)[dateComponents day]];
    }
}

+ (NSString *)commentDate:(NSTimeInterval)time {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];

    return [NSString stringWithFormat:@"%ld月%ld日 %ld时%ld分", (long)[dateComponents month], (long)[dateComponents day], (long)[dateComponents hour], (long)[dateComponents minute]];
}

@end
