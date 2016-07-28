//
//  SAPopularModel.m
//  Sigma
//
//  Created by Terence on 16/7/15.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAPopularModel.h"

@implementation SAPopularModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        // key 
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}



+ (instancetype)popularModelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
