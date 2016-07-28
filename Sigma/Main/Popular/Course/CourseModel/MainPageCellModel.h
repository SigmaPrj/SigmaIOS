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

-(instancetype)initWithDictionary:(NSDictionary*)dic;

@end
