//
//  SAMineViewEngine.h
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAUser;

@interface SAMineViewEngine : NSObject

+(instancetype)shareInstance;

-(NSArray*)dataSection1;
-(NSArray*)dataSection2;
-(NSArray*)dataSection3;

-(void)mineSetUser:(SAUser*)user;
-(SAUser*)mineGetUser;
-(void)mineInitDataSection:(NSDictionary*)list;

@end
