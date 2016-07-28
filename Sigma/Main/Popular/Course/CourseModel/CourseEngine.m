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

@interface CourseEngine ()

//主页headview的scrollview的图片的array
@property(nonatomic,strong)NSMutableArray* scrollViewDataArray;

//主页cell的array
@property(nonatomic,strong)NSMutableArray* cellDataArray;

//search界面的数据array
@property(nonatomic,strong)NSMutableArray* searchInfoArray;

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
        //主页cell的测试数据
        NSMutableArray* cellListArray = [NSMutableArray array];
        NSDictionary* dictForCell1 = @{@"imageName":@"scrollView1.png",
                                      @"className":@"编程入门",
                                      @"numOfStudy":@"30"};
        NSDictionary* dictForCell2 = @{@"imageName":@"scrollView1.png",
                                      @"className":@"编程入门",
                                      @"numOfStudy":@"30"};
        
        [cellListArray addObject:dictForCell1];
        [cellListArray addObject:dictForCell2];
/////////////////////////////////////////////////////////////////////////////
        
        [self cellWithArray:cellListArray];
        
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
    }}

-(NSArray*)scrollViewWithData{
    return self.scrollViewDataArray;
}

-(NSArray*)cellWithData{
    return self.cellDataArray;
}

-(NSArray*)searchWithData{
    return self.searchInfoArray;
}

@end
