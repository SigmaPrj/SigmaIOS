//
//  SAGroupModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/10.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAGroupModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger *online;

@property (nonatomic, strong) NSMutableArray *friends;

// 记录该组是否展开，默认是NO
@property (nonatomic, assign,getter=isExplain) BOOL explain;


- (instancetype)initWithDict:(NSDictionary *)dict;


+ (instancetype)groupsModelWith:(NSDictionary *)dict;

@end
