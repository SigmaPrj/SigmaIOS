//
//  CategoryInfo.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryInfo : NSObject

//每个cell的名称
@property(nonatomic,copy)NSString* cellName;

//第一个图片的名字
@property(nonatomic,copy)NSString* imageName1;

//第一个label内容
@property(nonatomic,copy)NSString* desLabel1;

//第一个数量label的数字
@property(nonatomic,assign)int numLabel1;

//第二个图片的名字
@property(nonatomic,copy)NSString* imageName2;

//第二个label内容
@property(nonatomic,copy)NSString* desLabel2;

//第二个数量label的数字
@property(nonatomic,assign)int numLabel2;

//第三个图片的名字
@property(nonatomic,copy)NSString* imageName3;

//第三个label内容
@property(nonatomic,copy)NSString* desLabel3;

//第三个数量label的数字
@property(nonatomic,assign)int numLabel3;

//第四个图片的名字
@property(nonatomic,copy)NSString* imageName4;

//第四个label内容
@property(nonatomic,copy)NSString* desLabel4;

//第四个数量label的数字
@property(nonatomic,assign)int numLabel4;

//第五个图片的名字
@property(nonatomic,copy)NSString* imageName5;

//第五个label内容
@property(nonatomic,copy)NSString* desLabel5;

//第五个数量label的数字
@property(nonatomic,assign)int numLabel5;

//第六个图片的名字
@property(nonatomic,copy)NSString* imageName6;

//第六个label内容
@property(nonatomic,copy)NSString* desLabel6;

//第六个数量label的数字
@property(nonatomic,assign)int numLabel6;




-(instancetype)initWithDictionary:(NSDictionary*)dic;

+(instancetype)categoryModelWithDict:(NSDictionary*)dic;

@end
