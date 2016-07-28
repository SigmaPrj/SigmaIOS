//
//  SearchTrendWordsModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/21.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SearchTrendWordsModel.h"

@implementation SearchTrendWordsModel

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
