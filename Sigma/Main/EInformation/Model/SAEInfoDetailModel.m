//
//  SAEInfoDetailModel.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInfoDetailModel.h"

@implementation SAEInfoDetailModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}


+(instancetype)einformationModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
