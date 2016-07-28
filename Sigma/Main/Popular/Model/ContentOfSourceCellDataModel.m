//
//  ContentOfSourceCellDataModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "ContentOfSourceCellDataModel.h"

@implementation ContentOfSourceCellDataModel

-(instancetype)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)categoryModelWithDict:(NSDictionary*)dic{
    return [[self alloc] initWithDictionary:dic];
}

@end
