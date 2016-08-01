//
//  SourceEngineInterface.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SourceEngineInterface : NSObject

/*
 创建一个engine的单例
 */

+(instancetype)shareInstances;


/*
 
 让外部通过这个类的对象调用这个方法，来获得这个页面的数据array
 
 */

-(NSArray*)sourcePageWithData;

-(void)sourcePageWithArray:(NSArray*)listArray;

@end
