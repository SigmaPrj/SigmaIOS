//
//  SAEInformationTypeModel.m
//  Sigma
//
//  Created by Terence on 16/8/2.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "SAEInformationTypeModel.h"

@implementation SAEInformationTypeModel

- (instancetype) initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
        _news_id = [dict[@"id"] intValue];
        _news_name = dict[@"name"];
        _news_img = dict[@"image"];

    }
    return self;
}

+ (instancetype) newsTypeWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
