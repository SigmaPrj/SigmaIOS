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
#import "CategoryInfo.h"
#import "SearchTrendWordsModel.h"
#import "ContentOfSourceInfo.h"

@interface SourceEngineInterface ()

//source界面的数据array
@property(nonatomic,strong)NSMutableArray* sourceInfoArray;

//category界面的数据array
@property(nonatomic,strong)NSMutableArray* categoryInfoArray;

//search界面的数据array
@property(nonatomic,strong)NSMutableArray* searchInfoArray;

//contentOfSource界面的数据array
@property(nonatomic,strong)NSMutableArray* contentOfSourceInfoArray;

//contentOfSource界面cell的数据array
@property(nonatomic,strong)NSMutableArray* contentOfSourceCellInfoArray;

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
        
        
        //source界面测试用的数据
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
        
        
        _categoryInfoArray = [NSMutableArray array];
        
        
        
        //category界面测试用的数据
        NSMutableArray* listArrayForCategory = [NSMutableArray array];
        
        NSDictionary* dic1 = @{@"cellName":@"前端开发",
                              @"imageName1":@"catogorySecondInfo3.png",
                               @"desLabel1":@"HTML",
                               @"numLabel1":@"44",
                               @"imageName2":@"catogorySecondInfo3.png",
                               @"desLabel2":@"JavaScipt",
                               @"numLabel2":@"44",
                               @"imageName3":@"catogorySecondInfo3.png",
                               @"desLabel3":@"HTML",
                               @"numLabel3":@"44",
                               @"imageName4":@"catogorySecondInfo3.png",
                               @"desLabel4":@"JavaScipt",
                               @"numLabel4":@"44",
                               @"imageName5":@"catogorySecondInfo3.png",
                               @"desLabel5":@"HTML",
                               @"numLabel5":@"44",
                               @"imageName6":@"catogorySecondInfo3.png",
                               @"desLabel6":@"JavaScipt",
                               @"numLabel6":@"44"
                              };
        [listArrayForCategory addObject:dic1];
    ///////////////////////////////////////////////////////////////////
        
        [self categoryPageWithArray:listArrayForCategory];
        
        _searchInfoArray = [NSMutableArray array];
        //source界面测试用的数据
        NSMutableArray* listArrayForSearch = [NSMutableArray array];
        NSDictionary* dictForSearch1 = @{@"trendWord":@"前端"};
        NSDictionary* dictForSearch2 = @{@"trendWord":@"脱口秀"};
        NSDictionary* dictForSearch3 = @{@"trendWord":@"脱口秀"};
        NSDictionary* dictForSearch4 = @{@"trendWord":@"脱口秀"};
        NSDictionary* dictForSearch5 = @{@"trendWord":@"脱口秀"};
        [listArrayForSearch addObject:dictForSearch1];
        [listArrayForSearch addObject:dictForSearch2];
        [listArrayForSearch addObject:dictForSearch3];
        [listArrayForSearch addObject:dictForSearch4];
        [listArrayForSearch addObject:dictForSearch5];
/////////////////////////////////////////////////////////////////////////////
        
        [self searchPageWithArray:listArrayForSearch];
        
    
        
        
    }
    return self;
}

//初始化ContentOfSource的headView的数据
-(instancetype)initContentOfSourceHeadView{
    self = [super init];
    if(self){
    //contentOfSource的headview测试用的数据
    NSMutableArray* listArrayForContentHeadview = [NSMutableArray array];
    NSDictionary* dictForContent = @{@"sourceName":self.sourceName,
                                     @"descriptionOfSource":self.descriptionOfSource};
    [listArrayForContentHeadview addObject:dictForContent];
    [self contentOfSourcePageWithArray:listArrayForContentHeadview];
///////////// / / //////////////////////////////////////////////////////////////
    }
    return self;
}

//传入一个array，然后拿到array 中的内容，添加到sourceInfoArray中
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

//传入一个array，然后拿到array 中的内容，添加到categoryInfoArray中
-(void)categoryPageWithArray:(NSArray*)listArray{
    for(int index=0; index<listArray.count; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        [_categoryInfoArray addObject:dic];
    }
}

//传入一个array，然后拿到array 中的内容，添加到searchInfoArray中
-(void)searchPageWithArray:(NSArray*)listArray{
    for(int index=0; index<listArray.count; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        SearchTrendWordsModel* searchInfo = [[SearchTrendWordsModel alloc] initWithDictionary:dic];
        [_searchInfoArray addObject:searchInfo];
}}

//传入一个array，然后拿到array 中的内容，添加到contentOfSourceInfoArray中
-(void)contentOfSourcePageWithArray:(NSArray*)listArray{
    for(int index=0; index<listArray.count; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        ContentOfSourceInfo* contentInfo = [[ContentOfSourceInfo alloc] initWithDictionary:dic];
        [_contentOfSourceInfoArray addObject:contentInfo];
    }
}

//一个获得数据的接口
-(void)getDataFromView:(NSString*)sourceName andSupportNumber:(NSString*)supportNumber andDownloadNumber:(NSString*)downloadNumber{
    _contentOfSourceInfoArray = [NSMutableArray array];
    //contentOfSource的headview测试用的数据
    NSMutableArray* listArrayForContentHeadview = [NSMutableArray array];
    NSDictionary* dictForContent = @{@"sourceName":sourceName,
                                     @"descriptionOfSource":@"资源描述。consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo.",
                                     @"supportNumber":supportNumber,
                                     @"downloadNumber":downloadNumber};
    [listArrayForContentHeadview addObject:dictForContent];
    ///////////// / / //////////////////////////////////////////////////////////////
    [self contentOfSourcePageWithArray:listArrayForContentHeadview];
}


-(NSArray*)sourcePageWithData{
    return self.sourceInfoArray;
}

-(NSArray*)categoryPageWithData{
    return self.categoryInfoArray;
}

-(NSArray*)searchPageWithData{
    return self.searchInfoArray;
}

-(NSArray*)contentOfSourcePageWithData{
    return self.contentOfSourceInfoArray;
}

-(NSArray*)contentOfSourceCellWithData{
    return self.contentOfSourceCellInfoArray;
}

@end
