//
//  SAQuestionViewEngine.h
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMyQuestionViewEngine : NSObject

+(instancetype)shareInstance;

-(NSArray*)dataSection;

-(void)questionInitDataSection:(NSDictionary*)list;

@end
