//
//  MainPageCellModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPageCellModel : NSObject

//cell头图片的名称
@property(nonatomic,copy)NSString* imageName;

//每个cell课程的名称
@property(nonatomic,copy)NSString* className;

//每个cell课程学习的数量
@property(nonatomic,assign)int numOfStudy;

//每个课程的具体描述
@property(nonatomic,copy)NSString* descriptionOfCourse;

//作者的头像的名称
@property(nonatomic,copy)NSString* headImageName;

//作者的别称
@property(nonatomic,copy)NSString* nickname;

//作者的城市
@property(nonatomic,copy)NSString* city;

//课程视频的url地址
@property(nonatomic,copy)NSString* courseVideoUrlPath;

-(instancetype)initWithDictionary:(NSDictionary*)dic;
+(instancetype)categoryModelWithDict:(NSDictionary*)dic;

@end
