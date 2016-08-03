//
//  SAEInformationTypeModel.h
//  Sigma
//
//  Created by Terence on 16/8/2.
//  Copyright © 2016年 韩佳成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEInformationTypeModel : NSObject

@property(nonatomic, assign) int news_id;
@property(nonatomic, copy) NSString* news_name;
@property(nonatomic, copy) NSString* news_img;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) newsTypeWithDict:(NSDictionary *)dict;

@end
