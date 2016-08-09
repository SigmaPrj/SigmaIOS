//
//  SourceMainPageInfo.h
//  Sigma
//
//  Created by 韩佳成 on 16/8/1.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceMainPageInfo : NSObject

//source界面每个cell后面资源的名字
@property(nonatomic,copy)NSString* title;

//source界面每个cell的时间戳
@property(nonatomic,copy)NSString* publish_date;

//source界面每个cell具体的描述
@property(nonatomic,copy)NSString* desc;

//source界面每个cell右下角点赞的数量
@property(nonatomic,assign)int save;

//source界面每个cell右下角评论的数量
@property(nonatomic,assign)int look;

//source界面每个cell右下角下载的数量
@property(nonatomic,assign)int download;

//source界面每个cell左下角图片的名称
@property(nonatomic,copy)NSString* image;


@end
