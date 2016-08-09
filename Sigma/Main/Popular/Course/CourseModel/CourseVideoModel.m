//
//  CourseVideoModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/8.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "CourseVideoModel.h"

@implementation CourseVideoModel

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
