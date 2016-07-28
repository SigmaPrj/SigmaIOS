//
//  CourseEngine.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseEngine : NSObject

+(instancetype)shareInstances;

/*
 
 让外部获得scrollview的数组
 
 */
-(NSArray*)scrollViewWithData;

/*
 
 让外部获得cellDataArray的数组
 
 */

-(NSArray*)cellWithData;

/*
 
 让外部获得searchInfoArray的数组
 
 */

-(NSArray*)searchWithData;

 

@end
