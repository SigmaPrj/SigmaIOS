//
//  SAEInfoEngineInterface.m
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SAEInfoEngineInterface.h"

@implementation SAEInfoEngineInterface

//
+(instancetype)shareInstances{
    static SAEInfoEngineInterface* instances = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instances = [[SAEInfoEngineInterface alloc] init];
    });
    
    return instances;
}

-(instancetype)init{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}



@end
