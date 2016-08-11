//
//  AuthorInfoModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/8/8.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorInfoModel : NSObject

//作者头像的名称
@property(nonatomic,copy)NSString* headImageName;

//作者昵称
@property(nonatomic,copy)NSString* nickName;

//作者的城市
@property(nonatomic,copy)NSString* city;

-(instancetype)initWithDictionary:(NSDictionary*)dic;

+(instancetype)categoryModelWithDict:(NSDictionary*)dic;

@end
