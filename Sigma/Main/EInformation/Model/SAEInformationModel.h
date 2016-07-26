//
//  SAEInformationModel.h
//  Sigma
//
//  Created by Terence on 16/7/18.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEInformationModel : NSObject

@property(nonatomic, copy)NSString* desc;
@property(nonatomic, copy)NSString* mainImgName;
@property(nonatomic, assign)int number;


// 对象方法，初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法初始化
+ (instancetype)einformationModelWithDict:(NSDictionary *)dict;

@end
