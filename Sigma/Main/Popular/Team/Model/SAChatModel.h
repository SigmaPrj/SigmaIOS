//
//  SAChatModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAChatModel : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger fromUser;
@property (nonatomic, assign) NSInteger toUser;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)chatWthDict:(NSDictionary *)dict;

@end
