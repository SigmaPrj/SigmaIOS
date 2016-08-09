//
//  CategoryPageModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/4.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "CategoryPageModel.h"

@implementation CategoryPageModel

-(instancetype)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if(self){
        _cellName = dic[@"name"];
        _listArray = [dic[@"categories"] copy];
        if(self.listArray.count>=6){
            NSDictionary* dic1 = [self.listArray objectAtIndex:0];
            _imageName1 = dic1[@"image"];
            _desLabel1 = dic1[@"name"];
            
            NSDictionary* dic2 = [self.listArray objectAtIndex:1];
            _imageName2 = dic2[@"image"];
            _desLabel2 = dic2[@"name"];
            
            NSDictionary* dic3 = [self.listArray objectAtIndex:2];
            _imageName3 = dic3[@"image"];
            _desLabel3 = dic3[@"name"];
            
            NSDictionary* dic4 = [self.listArray objectAtIndex:3];
            _imageName4 = dic4[@"image"];
            _desLabel4 = dic4[@"name"];
            
            NSDictionary* dic5 = [self.listArray objectAtIndex:4];
            _imageName5 = dic5[@"image"];
            _desLabel5 = dic5[@"name"];
            
            NSDictionary* dic6 = [self.listArray objectAtIndex:5];
            _imageName6 = dic6[@"image"];
            _desLabel6 = dic6[@"name"];
        }else if(self.listArray.count == 4){
            NSDictionary* dic1 = [self.listArray objectAtIndex:0];
            _imageName1 = dic1[@"image"];
            _desLabel1 = dic1[@"name"];
            
            NSDictionary* dic2 = [self.listArray objectAtIndex:1];
            _imageName2 = dic2[@"image"];
            _desLabel2 = dic2[@"name"];
            
            NSDictionary* dic3 = [self.listArray objectAtIndex:2];
            _imageName3 = dic3[@"image"];
            _desLabel3 = dic3[@"name"];
            
            NSDictionary* dic4 = [self.listArray objectAtIndex:3];
            _imageName4 = dic4[@"image"];
            _desLabel4 = dic4[@"name"];
            
            _imageName5 = @"";
            _desLabel5 = @"";
            
            _imageName6 = @"";
            _desLabel6 = @"";
        }
    }
    return self;
}

+(instancetype)categoryModelWithDict:(NSDictionary*)dic{
    return [[self alloc] initWithDictionary:dic];
}


@end
