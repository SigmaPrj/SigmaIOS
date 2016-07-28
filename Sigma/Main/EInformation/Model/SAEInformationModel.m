//
//  SAEInformationModel.m
//  Sigma
//
//  Created by Terence on 16/7/18.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInformationModel.h"

@implementation SAEInformationModel

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
