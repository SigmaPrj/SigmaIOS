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
#import "ResourceMainPageModel.h"
#import "ResourceMainPageRequest.h"
#import "CategoryPageModel.h"
#import "ResourceCategoryRequest.h"

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
        
        
        [self addAllNotification];
        
        [ResourceMainPageRequest requestResourceMainPageData];
        
//        //source界面测试用的数据
//        NSMutableArray* listArray = [NSMutableArray array];
//        
//        //将时间戳转化成date，然后再将date转行成输出string格式
//        NSDate* publish_date1 = [NSDate dateWithTimeIntervalSince1970:1347590275];
//        NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];
//        [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
//        NSString* dateStr = [dateFormat1 stringFromDate:publish_date1];
//        
//        NSDictionary* dictForResource1 = @{@"title":@"编程开发从入门到精通",
//                                           @"publish_date":dateStr,
//                                           @"desc":@"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.",
//                                           @"save":@"6",
//                                           @"look":@"3",
//                                           @"download":@"12",
//                                           @"image":@"http://oaetkzt9k.bkt.clouddn.com/CSS3.jpg"};
//        [listArray addObject:dictForResource1];
//        
//        NSDictionary* dictForResource2 = @{@"title":@"编程开发从入门到精通",
//                                           @"publish_date":dateStr,
//                                           @"desc":@"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.",
//                                           @"save":@"6",
//                                           @"look":@"3",
//                                           @"download":@"12",
//                                            @"image":@"http://oaetkzt9k.bkt.clouddn.com/CSS3.jpg"};
//        [listArray addObject: dictForResource2];
//        
//        NSDictionary* dictForResource3 = @{@"title":@"编程开发从入门到精通",
//                                           @"publish_date":dateStr,
//                                           @"desc":@"Lore, ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverrra justo commodo.",
//                                           @"save":@"6",
//                                           @"look":@"3",
//                                           @"download":@"12",
//                                            @"image":@"http://oaetkzt9k.bkt.clouddn.com/CSS3.jpg"};
//        [listArray addObject: dictForResource3];
//        
// ///////////////////////////////////////////////////////////////////
//        
//        [self sourcePageWithArray:listArray];
        
        
        
        _categoryInfoArray = [NSMutableArray array];
        
        [self addCategoryNotification];
        
        [ResourceCategoryRequest requestCategoryOfResourceData];
        
//        //category界面测试用的数据
//        NSMutableArray* listArrayForCategory = [NSMutableArray array];
//        
//        NSDictionary* dic1 = @{@"cellName":@"前端开发",
//                              @"imageName1":@"catogorySecondInfo3.png",
//                               @"desLabel1":@"HTML",
//                               @"numLabel1":@"44",
//                               @"imageName2":@"catogorySecondInfo3.png",
//                               @"desLabel2":@"JavaScipt",
//                               @"numLabel2":@"44",
//                               @"imageName3":@"catogorySecondInfo3.png",
//                               @"desLabel3":@"HTML",
//                               @"numLabel3":@"44",
//                               @"imageName4":@"catogorySecondInfo3.png",
//                               @"desLabel4":@"JavaScipt",
//                               @"numLabel4":@"44",
//                               @"imageName5":@"catogorySecondInfo3.png",
//                               @"desLabel5":@"HTML",
//                               @"numLabel5":@"44",
//                               @"imageName6":@"catogorySecondInfo3.png",
//                               @"desLabel6":@"JavaScipt",
//                               @"numLabel6":@"44"
//                              };
//        [listArrayForCategory addObject:dic1];
//    ///////////////////////////////////////////////////////////////////
//        
//        [self categoryPageWithArray:listArrayForCategory];
        
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
        NSDictionary* dic = [listArray objectAtIndex:index];
        ResourceMainPageModel* resourceMainPageModel = [[ResourceMainPageModel alloc] initWithDict:dic];
        [_sourceInfoArray addObject:resourceMainPageModel];
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
-(void)getDataFromView:(NSString*)sourceName andSupportNumber:(NSString*)supportNumber andDownloadNumber:(NSString*)downloadNumber andDescription:(NSString*)description{
    _contentOfSourceInfoArray = [NSMutableArray array];
    //contentOfSource的headview测试用的数据
    NSMutableArray* listArrayForContentHeadview = [NSMutableArray array];
    NSDictionary* dictForContent = @{@"sourceName":sourceName,
                                     @"descriptionOfSource":description,
                                     @"supportNumber":supportNumber,
                                     @"downloadNumber":downloadNumber};
    [listArrayForContentHeadview addObject:dictForContent];
    ///////////// / / //////////////////////////////////////////////////////////////
    [self contentOfSourcePageWithArray:listArrayForContentHeadview];
}

//一个获得category界面数据的接口
-(void)categoryGetData{
    
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

#pragma mark - 添加通知
-(void)addAllNotification{
    //添加source的cell的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resourceReceiveSuccessData:) name:NOTI_RESOURCE_MAINPAGE_DATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resourceReveiveFailData:) name:REQUEST_DATA_ERROR object:nil];
}

-(void)removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)resourceReceiveSuccessData:(NSNotification*)noti{
    if([noti.name isEqualToString:NOTI_RESOURCE_MAINPAGE_DATA]){
        if([noti.userInfo[@"status"] intValue] == 1){
            [self setSourceMainPageData:noti.userInfo[@"data"]];
        }
    }
}

-(void)resourceReveiveFailData:notification{
    NSLog(@"加载失败");
}

//source主界面
-(void)setSourceMainPageData:(NSArray*)sourceMainPageArray{
    for(int i=0 ; i<sourceMainPageArray.count ; i++){
        ResourceMainPageModel* sourceMainPageModel = [ResourceMainPageModel sourceMainPageModelWithDict:sourceMainPageArray[(NSInteger)i]];
        [_sourceInfoArray addObject:sourceMainPageModel];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_RESOURCE_MAINPAGE_MAINQUEUE_DATA object:nil];
        
    });
}

/*
 
 category界面通知处理
 
 */

//添加通知
-(void)addCategoryNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryReceiveSuccessData:) name:CATEGORY_PAGE_DATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(categoryReceiveFailData:) name:REQUEST_DATA_ERROR object:nil];
}

//通知的处理方法
-(void)categoryReceiveSuccessData:(NSNotification*)noti{
    if([noti.name isEqualToString:CATEGORY_PAGE_DATA]){
        if([noti.userInfo[@"status"] intValue] == 1){
            [self setCategoryPageData:noti.userInfo[@"data"]];
            NSArray* array = noti.userInfo[@"data"];
            NSLog(@"%lu", array.count);
            
        }
    }
}

-(void)categoryReceiveFailData:notification{
    NSLog(@"category界面加载数据失败");
}

//category界面解析数据的方法
-(void)setCategoryPageData:(NSArray*)categoryPageArray{
    for(int i=0 ; i<categoryPageArray.count ; i++){
//        CategoryPageModel* categoryPageModel = [CategoryPageModel categoryModelWithDict:categoryPageArray[(NSInteger)(i)]];
//        [_categoryInfoArray addObject:categoryPageModel];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:CATEGORY_PAGE_MAINQUEUE_DATA object:nil];
    });
}

@end
