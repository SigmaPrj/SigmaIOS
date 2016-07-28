//
//  SearchTrendWordsModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/21.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTrendWordsModel : NSObject

@property(nonatomic,copy)NSString* trendWord;

-(instancetype)initWithDictionary:(NSDictionary*)dic;

+(instancetype)searchModelWithDict:(NSDictionary*)dic;
@end
