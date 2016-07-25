//
//  PublicDefine.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/15.
//  Copyright (c) 2016 Terence. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

// 屏幕宽高设置
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 颜色设置操作
#define COLOR_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 位置获取操作
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

// Sigma主色调
#define SIGMA_COLOR [UIColor colorWithRed:0.196  green:0.200  blue:0.208 alpha:1]


// Community社区页面常用值
#define COMMUNITY_PADDING 15
#define COMMUNITY_BORDER_WIDTH 1
#define COMMUNITY_HEADER_VIEW_HEIGHT 170
#define COMMUNITY_APPROVED_IMAGE @"avatar_vip"
#define COMMUNITY_APPROVED_IMAGE_SIZE 14
#define COMMUNITY_BORDER_COLOR [UIColor colorWithRed:0.82 green:0.82 blue:0.82 alpha:1.00]
#define COMMUNITY_APPROVED_NAME_COLOR [UIColor colorWithRed:1.00 green:0.69 blue:0.00 alpha:1.00]
#define COMMUNITY_TEXT_COLOR [UIColor blackColor];
// 动态cell
#define DYNAMIC_USERNAME_FONT_SIZE 18

#endif /* PublicDefine_h */
