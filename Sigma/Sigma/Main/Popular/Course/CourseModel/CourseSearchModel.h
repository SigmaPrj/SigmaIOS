//
//  CourseSearchModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseSearchModel : NSObject

@property(nonatomic,copy)NSString* trendWord;

-(instancetype)initWithDictionary:(NSDictionary*)dic;

+(instancetype)searchModelWithDict:(NSDictionary*)dic;

@end
