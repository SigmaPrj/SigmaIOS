//
//  SourceEngineInterface.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

/*
 
 怎样设置一个接口给后台，然后使listarray可以获得数据
 
 NSDate的值怎样获取
 
 左下角的图标怎样获取，要获取很多不同的图片的名称
 
 右下角那些数字怎样实时获取
 
 */

#import "SourceEngineInterface.h"
#import "SourceInfo.h"

@interface SourceEngineInterface ()

@property(nonatomic,strong)NSMutableArray* sourceInfoArray;

@end

@implementation SourceEngineInterface

//单例
+(instancetype)shareInstances{
    static SourceEngineInterface* instances = nil;
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken,^{
        instances = [[SourceEngineInterface alloc] init];
    });
    return instances;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _sourceInfoArray = [NSMutableArray array];
        
        
        //测试用的数据
        NSMutableArray* listArray = [NSMutableArray array];
        
        SourceInfo* sourceInfo1 = [[SourceInfo alloc] init];
        sourceInfo1.sourceName = @"编程开发从入门到精通";
        NSDateFormatter* dataFormat1 = [[NSDateFormatter alloc] init];
        [dataFormat1 setDateFormat:@"yyyy-MM-dd"];
        sourceInfo1.dateStr = [dataFormat1 stringFromDate:[NSDate date]];
        sourceInfo1.sourceDescription = @"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.";
        sourceInfo1.imageName = [NSString stringWithFormat:@"leftBottomLabelImage1.png"];
        sourceInfo1.supportNumber = 6;
        sourceInfo1.commentNumber = 3;
        sourceInfo1.downloadNumber = 12;
        
        [listArray addObject:sourceInfo1];
        
        
        SourceInfo* sourceInfo2 = [[SourceInfo alloc] init];
        sourceInfo2.sourceName = @"编程开发从入门到精通";
        NSDateFormatter* dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
        sourceInfo2.dateStr = [dateFormat2 stringFromDate:[NSDate date]];
        sourceInfo2.sourceDescription = @"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.";
        sourceInfo2.imageName = [NSString stringWithFormat:@"leftBottomLabelImage1.png"];
        sourceInfo2.supportNumber = 6;
        sourceInfo2.commentNumber = 3;
        sourceInfo2.downloadNumber = 12;

        [listArray addObject:sourceInfo2];
        
        SourceInfo* sourceInfo3 = [[SourceInfo alloc] init];
        sourceInfo3.sourceName = @"编程开发从入门到精通";
        NSDateFormatter* dataFormat3 = [[NSDateFormatter alloc] init];
        [dataFormat3 setDateFormat:@"yyyy-MM-dd"];
        sourceInfo3.dateStr = [dataFormat1 stringFromDate:[NSDate date]];
        sourceInfo3.sourceDescription = @"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.";
        sourceInfo3.imageName = [NSString stringWithFormat:@"leftBottomLabelImage1.png"];
        sourceInfo3.supportNumber = 6;
        sourceInfo3.commentNumber = 3;
        sourceInfo3.downloadNumber = 12;
        
        [listArray addObject:sourceInfo3];
 ///////////////////////////////////////////////////////////////////
        
        [self sourcePageWithArray:listArray];
    }
    return self;
}

-(void)sourcePageWithArray:(NSArray *)listArray{
    for(int index=0; index<listArray.count; index++){
        //取出listarray中的对象
        NSObject* object = [listArray objectAtIndex:index];
        //将去处的对象转成sourceInfo
        SourceInfo* sourceInfo = [[SourceInfo alloc] init];
        sourceInfo = (SourceInfo*)object;
        //添加到数组属性中
        [_sourceInfoArray addObject:sourceInfo];
    }
}

-(NSArray*)sourcePageWithData{
    return self.sourceInfoArray;
}

@end
