//
//  SAPopularModel.h
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPopularModel : NSObject

@property(nonatomic, copy)NSString* AvataImgName;
@property(nonatomic, copy)NSString* cellBackgroundImgName;
@property(nonatomic, copy)NSString* nickName;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* desc;

@property (nonatomic, assign) double cellHeight;
@property(nonatomic, assign)int number;

// 可能有type
@property(nonatomic, assign)int type;

// 对象方法，初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法初始化
+ (instancetype)popularModelWithDict:(NSDictionary *)dict;

@end
