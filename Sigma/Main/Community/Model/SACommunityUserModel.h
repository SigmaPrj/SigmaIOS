//
//  SACommunityUserModel.h
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACommunityUserModel : NSObject

@property (nonatomic, assign) int user_id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *bgImage;
@property (nonatomic, assign) int is_approved;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) userModelWithDict:(NSDictionary *)dict;

@end
