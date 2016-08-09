//
//  CourseVideoModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/8/8.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseVideoModel : NSObject

//课程视频的url地址
@property(nonatomic,copy)NSString* courseVideoUrlPath;


-(instancetype)initWithDictionary:(NSDictionary*)dic;

+(instancetype)categoryModelWithDict:(NSDictionary*)dic;

@end
