
//
//  CourseSearchModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CourseSearchModel.h"

@implementation CourseSearchModel

-(instancetype)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)searchModelWithDict:(NSDictionary*)dic{
    return [[self alloc] initWithDictionary:dic];
}


@end
