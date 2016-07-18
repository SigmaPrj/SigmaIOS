//
//  SourceInfo.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceInfo : NSObject

//source界面每个cell后面资源的名字
@property(nonatomic,copy)NSString* sourceName;

//source界面每个cell的时间
@property(nonatomic,copy)NSString* dateStr;

//source界面每个cell具体的描述
@property(nonatomic,copy)NSString* sourceDescription;

//source界面每个cell左下角的图标
@property(nonatomic,copy)NSString* imageName;

//source界面每个cell右下角点赞的数量
@property(nonatomic,assign)int supportNumber;

//source界面每个cell右下角评论的数量
@property(nonatomic,assign)int commentNumber;

//source界面每个cell右下角下载的数量
@property(nonatomic,assign)int downloadNumber;

@end
