//
//  SADynamicFrameModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SADynamicModel;
// 用于存放所有 cell 组件的frame以及整个cell 的高度值
@interface SADynamicFrameModel : NSObject

// 一些frame
@property (nonatomic, assign, readonly) CGRect avatarFrame; // 头像显示位置
@property (nonatomic, assign, readonly) CGRect nicknameFrame; // 昵称显示位置
@property (nonatomic, assign, readonly) CGRect schoolFrame; // 学校显示位置
@property (nonatomic, assign, readonly) CGRect levelFrame; // 等级显示位置
@property (nonatomic, assign, readonly) CGRect contentFrame; // 内容位置
@property (nonatomic, assign, readonly) CGRect dateFrame; // 日期显示位置
@property (nonatomic, assign, readonly) CGRect imagesFrame; // 6张图片组成的view的位置

@property (nonatomic, assign, readonly) CGRect lookBtnFrame; // 多少人浏览
@property (nonatomic, assign, readonly) CGRect praiseBtnFrame; // 点赞
@property (nonatomic, assign, readonly) CGRect commentBtnFrame; // 评论

@property (nonatomic, assign, getter=hasTopic) BOOL hasTopic; // 是否有话题
@property (nonatomic, assign, getter=isApproved) BOOL isApproved; // 是否被认证

// dynamic model
@property (nonatomic, strong) SADynamicModel *dynamicModel;

@end
