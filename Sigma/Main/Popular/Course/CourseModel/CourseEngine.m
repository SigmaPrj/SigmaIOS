//
//  CourseEngine.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CourseEngine.h"
#import "ScrollViewModel.h"
#import "MainPageCellModel.h"
#import "CourseSearchModel.h"
#import "CourseMainPageRequest.h"
#import "BriefIntroductionModel.h"
#import "AuthorInfoModel.h"
#import "CourseVideoModel.h"

@interface CourseEngine ()

//主页headview的scrollview的图片的array
@property(nonatomic,strong)NSMutableArray* scrollViewDataArray;

//主页cell的array
@property(nonatomic,strong)NSMutableArray* cellDataArray;

//search界面的数据array
@property(nonatomic,strong)NSMutableArray* searchInfoArray;

//简介界面的数据array
@property(nonatomic,strong)NSMutableArray* briefIntroductionArray;

//作者界面的数据array
@property(nonatomic,strong)NSMutableArray* authorInfoArray;

//video界面视频的数据array
@property(nonatomic,strong)NSMutableArray* videoInfoArray;

@end


@implementation CourseEngine

+(instancetype)shareInstances{
    static CourseEngine* instances = nil;
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken,^{
        instances = [[CourseEngine alloc] init];
    });
    return instances;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _scrollViewDataArray = [NSMutableArray array];
        
        //主页scrollview用到的热门图片测试数据
        NSMutableArray* scrollViewImageListArray = [NSMutableArray array];
        NSDictionary* dictForScrollView1 = @{@"imageName":@"scrollView1.png"};
        NSDictionary* dictForScrollView2 = @{@"imageName":@"scrollView2.png"};
        NSDictionary* dictForScrollView3 = @{@"imageName":@"scrollView3.png"};
        NSDictionary* dictForScrollView4 = @{@"imageName":@"scrollView4.png"};
        
        [scrollViewImageListArray addObject:dictForScrollView1];
        [scrollViewImageListArray addObject:dictForScrollView2];
        [scrollViewImageListArray addObject:dictForScrollView3];
        [scrollViewImageListArray addObject:dictForScrollView4];
/////////////////////////////////////////////////////////////////////////////
        
        [self scrollViewWithArray:scrollViewImageListArray];
        
        
        
        _cellDataArray = [NSMutableArray array];
        
        [self addCourseMainPageNotification];
        
        [CourseMainPageRequest requestCourseMainPageData];
        
//        //主页cell的测试数据
//        NSMutableArray* cellListArray = [NSMutableArray array];
//        NSDictionary* dictForCell1 = @{@"imageName":@"scrollView1.png",
//                                      @"className":@"编程入门",
//                                      @"numOfStudy":@"30"};
//        NSDictionary* dictForCell2 = @{@"imageName":@"scrollView1.png",
//                                      @"className":@"编程入门",
//                                      @"numOfStudy":@"30"};
//        
//        [cellListArray addObject:dictForCell1];
//        [cellListArray addObject:dictForCell2];
///////////////////////////////////////////////////////////////////////////////
//        
//        [self cellWithArray:cellListArray];
        
         _searchInfoArray = [NSMutableArray array];
        //search界面测试用的数据
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

//传入一个array，然后拿到array 中的内容，添加到scrollViewDataArray中
-(void)scrollViewWithArray:(NSArray*)listArray{
    for(int index=0 ; index<listArray.count ; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        ScrollViewModel* scrollViewModel = [[ScrollViewModel alloc] initWithDictionary:dic];
        [_scrollViewDataArray addObject:scrollViewModel];
    }
}

//传入一个array，然后拿到array 中的内容，添加到cellDataArray中
-(void)cellWithArray:(NSArray*)listArray{
    for(int index=0; index<listArray.count; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        MainPageCellModel* mainPageCellModel = [[MainPageCellModel alloc] initWithDictionary:dic];
        [_cellDataArray addObject:mainPageCellModel];
    }
}

//传入一个array，然后拿到array 中的内容，添加到searchInfoArray中
-(void)searchPageWithArray:(NSArray*)listArray{
    for(int index=0; index<listArray.count; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        CourseSearchModel* courseSearchModel = [[CourseSearchModel alloc] initWithDictionary:dic];
        [_searchInfoArray addObject:courseSearchModel];
    }
}

//传入一个array，然后拿到array 中的内容，添加到briefIntroductionArray中
-(void)briefIntroductionWithArray:(NSArray*)listArray{
    for(int index=0 ; index<listArray.count ; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        BriefIntroductionModel* briefIntroductionMode = [[BriefIntroductionModel alloc] initWithDictionary:dic];
        [_briefIntroductionArray addObject:briefIntroductionMode];
    }
}

//传入一个array，然后拿到array 中的内容，添加到authorInfoArray中
-(void)authorInfoWithArray:(NSArray*)listArray{
    for(int index=0 ; index<listArray.count ; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        AuthorInfoModel* authorInfoModel = [[AuthorInfoModel alloc] initWithDictionary:dic];
        [_authorInfoArray addObject:authorInfoModel];
    }
}

//传入一个array，然后拿到array 中的内容，添加到videoInfoArray中
-(void)videoInfoWithArray:(NSArray*)listArray{
    for(int index=0 ; index<listArray.count ; index++){
        NSDictionary* dic = [listArray objectAtIndex:index];
        CourseVideoModel* courseVideoModel = [[CourseVideoModel alloc] initWithDictionary:dic];
        [_videoInfoArray addObject:courseVideoModel];
    }
}

//一个获得简介界面数据的接口
-(void)getDataFromIntroductionView:(NSString*)courseName andDescription:(NSString*)description {
    _briefIntroductionArray = [NSMutableArray array];
    NSMutableArray* listArray = [NSMutableArray array];
    NSDictionary* dictForBriefIntroduction = @{@"courseName":courseName,
                                               @"courseDescription":description,
                                               };
    [listArray addObject:dictForBriefIntroduction];
    [self briefIntroductionWithArray:listArray];
}

//一个获得作者信息界面数据的接口
-(void)getDataFromAuthorInfoView:(NSString*)headImageName andAuthorName:(NSString*)nickname andAuthorCity:(NSString*)city{
    _authorInfoArray = [NSMutableArray array];
    NSMutableArray* listArray = [NSMutableArray array];
    NSDictionary* dictForAuthorInfo = @{@"headImageName":headImageName,
                                        @"nickName":nickname,
                                        @"city":city};
    
    [listArray addObject:dictForAuthorInfo];
    [self authorInfoWithArray:listArray];
}

//一个获得课程视频信息数据的接口
-(void)getDataFromVideo:(NSString*)videoUrlPath{
    _videoInfoArray = [NSMutableArray array];
    NSMutableArray* listArray = [NSMutableArray array];
    NSDictionary* dictForAuthorInfo = @{@"courseVideoUrlPath":videoUrlPath};
    
    [listArray addObject:dictForAuthorInfo];
    [self videoInfoWithArray:listArray];
}

-(NSArray*)scrollViewWithData{
    return self.scrollViewDataArray;
}
-(NSArray*)cellWithData{
    return self.cellDataArray;
}

-(NSArray*)searchWithData{
    return self.searchInfoArray;
}

-(NSArray*)briefIntroductionWithData{
    return self.briefIntroductionArray;
}

-(NSArray*)authorInfoWithData{
    return self.authorInfoArray;
}

-(NSArray*)videoInfoWithData{
    return self.videoInfoArray;
}

#pragma mark - 添加通知
//添加course主界面请求的通知
-(void)addCourseMainPageNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(courseReceiveSuccessData:) name:COURSE_MAINPAGE_DATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(courseReceiveFailData:) name:REQUEST_DATA_ERROR object:nil];
}

//移除所有通知
-(void)removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//通知成功的方法
-(void)courseReceiveSuccessData:(NSNotification*)noti{
    if([noti.name isEqualToString:COURSE_MAINPAGE_DATA]){
        if([noti.userInfo[@"status"] intValue] == 1){
            [self setCourseMainPageData:noti.userInfo[@"data"]];
        }
    }
}

//通知失败的方法
-(void)courseReceiveFailData:notification{
    NSLog(@"source 主界面加载数据失败");
}

//通知成功解析数据
-(void)setCourseMainPageData:(NSArray*)courseMainPageArray{
    for(int i=0 ; i<courseMainPageArray.count ; i++){
        MainPageCellModel* mainPageCellModel = [MainPageCellModel categoryModelWithDict:courseMainPageArray[(NSInteger)i]];
        [_cellDataArray addObject:mainPageCellModel];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:COURSE_MAINPAGE_MAINQUEUE_DATA object:nil];
    });
}
    

@end
