//
//  SASettingViewEngine.h
//  Sigma
//
//  Created by Ace Hsieh on 7/25/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SASettingViewEngine : NSObject

+(instancetype)shareInstance;

-(NSArray*)dataSection1;
-(NSArray*)dataSection2;
-(NSArray*)dataSection3;

-(void)mineInitDataSection:(NSDictionary*)list;

@end
