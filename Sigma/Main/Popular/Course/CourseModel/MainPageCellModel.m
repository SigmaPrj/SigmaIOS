//
//  MainPageCellModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "MainPageCellModel.h"

@implementation MainPageCellModel

-(instancetype)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if(self){
//        [self setValuesForKeysWithDictionary:dic];
        _imageName = dic[@"image"];
        _className = dic[@"title"];
        _numOfStudy = [dic[@"learn"] intValue];
        _descriptionOfCourse = dic[@"description"];
        _headImageName = [dic valueForKeyPath:@"ouser.image"];
        _nickname = [dic valueForKeyPath:@"ouser.nickname"];
        _city = [dic valueForKeyPath:@"ouser.city"];
        _courseVideoUrlPath = dic[@"url"];
//        _courseVideoUrlPath = @"http://baobab.wandoujia.com/api/v1/playUrl?vid=8496&editionType=high&f=iphone&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&vc=67";
        
    }
    return self;
}

+(instancetype)categoryModelWithDict:(NSDictionary*)dic{
    return [[self alloc] initWithDictionary:dic];
}


@end
