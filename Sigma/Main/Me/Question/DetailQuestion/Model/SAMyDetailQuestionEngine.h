//
//  SAMyDetailQuestionEngine.h
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAMyDetailQuestionData;

@interface SAMyDetailQuestionEngine : NSObject

+(instancetype)shareInstance;

-(NSArray*)homeDetailPageWithData;

-(SAMyDetailQuestionData*)homeDetailPageDataWithIndex:(int)index;

-(void)homeDetailPageWithArray;

@end
