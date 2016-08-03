//
//  ResourceMainPageModel.m
//  Sigma
//
//  Created by 韩佳成 on 16/8/1.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import "ResourceMainPageModel.h"
#import "SADateHelper.h"

@implementation ResourceMainPageModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        // key
        _title = dict[@"title"];
        _publish_date = [SADateHelper humanizedDate:[dict[@"publish_date"]intValue]];
        _desc = dict[@"description"];
        _save = [dict[@"save"] intValue];
        _look = [dict[@"look"] intValue];
        _download = [dict[@"download"] intValue];
        _image = dict[@"image"];
        
    }
    
    return self;
}



+ (instancetype)sourceMainPageModelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
