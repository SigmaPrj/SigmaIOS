//
//  SourceEngineInterface.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceEngineInterface : NSObject

//资源的名称
@property(nonatomic,copy)NSString* sourceName;
//资源的具体描述
@property(nonatomic,copy)NSString* descriptionOfSource;
/*
 创建一个engine的单例
 */

+(instancetype)shareInstances;


/*
 
 让外部通过这个类的对象调用这个方法，来获得这个source页面的数据array
 
 */

-(NSArray*)sourcePageWithData;

-(void)sourcePageWithArray:(NSArray*)listArray;

/*
 
 让外部通过这个类的对象调用这个方法，来获得category页面的数据array
 
 */
-(NSArray*)categoryPageWithData;

/*
 
 让外部通过这个类的对象调用这个方法，来获得search页面的数据array
 
 */

-(NSArray*)searchPageWithData;

/*
 
 让外部通过这个类的对象调用这个方法，来获得contentOfSource页面的数据array
 
 */

-(NSArray*)contentOfSourcePageWithData;

/*
 
 一个获得数据的接口，在source界面调用此方法。
 
 */

-(void)getDataFromView:(NSString*)sourceName andSupportNumber:(NSString*)supportNumber andDownloadNumber:(NSString*)downloadNumber andDescription:(NSString*)description;


/*
 
 让外部通过这个类的对象调用这个方法，来获得contentOfSource页面的数据array
 
 */
-(NSArray*)contentOfSourceCellWithData;

/*
 
 移除获取数据的通知
 
 */

-(void)removeAllNotification;

/*
 
 获得category界面数据的接口
 
 */
-(void)categoryGetData;


@end
