//
//  SAUser.h
//  Sigma
//
//  Created by Ace Hsieh on 7/16/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAUser : NSObject

@property(nonatomic,copy)NSString* headImageName;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,assign)int level;

@property(nonatomic,assign)int feeds;
@property(nonatomic,assign)int numberOfFollowers;
@property(nonatomic,assign)int numberOfFans;
@property(nonatomic,assign)int credits;

@end
