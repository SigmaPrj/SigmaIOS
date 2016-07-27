//
//  ContentOfSourceCellDataModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentOfSourceCellDataModel : NSObject

//用户的头像图片的名称
@property(nonatomic,copy)NSString* headImageOfUser;

//用户昵称
@property(nonatomic,copy)NSString* userName;

//评论的时间
@property(nonatomic,copy)NSString* commentDate;

//评论的内容
@property(nonatomic,copy)NSString* contentOfComment;

@end
