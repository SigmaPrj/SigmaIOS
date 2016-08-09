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

/*
 
 让外部获得briefIntroductionArray的数组
 
 */

-(NSArray*)briefIntroductionWithData;


/*
 
 让外部获得authorInfoArray的数组
 
 */

-(NSArray*)authorInfoWithData;

/*
 
 让外部获得videoInfoArray的数组
 
 */
-(NSArray*)videoInfoWithData;

//移除所有通知
-(void)removeAllNotification;

//一个获得简介界面数据的接口
-(void)getDataFromIntroductionView:(NSString*)courseName andDescription:(NSString*)description ;

//一个获得作者信息界面数据的接口
-(void)getDataFromAuthorInfoView:(NSString*)headImageName andAuthorName:(NSString*)nickname andAuthorCity:(NSString*)city;

//一个获得课程视频信息数据的接口
-(void)getDataFromVideo:(NSString*)videoUrlPath;
 

@end
