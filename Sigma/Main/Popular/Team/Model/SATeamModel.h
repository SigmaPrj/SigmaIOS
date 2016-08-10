//
//  SATeamModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/11.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SATeamModel : NSObject

@property (nonatomic, copy) NSString *teamId;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *teamDesc;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *creator;

@property (nonatomic, assign) NSInteger tId;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)teamWithDict:(NSDictionary *)dict;

@end
