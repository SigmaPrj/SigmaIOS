//
//  ContentOfSouceHeadInfo.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/25.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentOfSouceHeadInfo : NSObject

//资源的名称
@property(nonatomic,copy)NSString* sourceName;

//资源的具体描述
@property(nonatomic,copy)NSString* descriptionOfSource;

//资源点赞数量
@property(nonatomic,copy)NSString* supportNumber;

//资源下载数量
@property(nonatomic,copy)NSString* downloadNumber;

@end
