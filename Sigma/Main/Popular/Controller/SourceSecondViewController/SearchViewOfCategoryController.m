//
//  SearchViewOfCategoryController.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/21.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SearchViewOfCategoryController.h"
#import "SourceCommonDefine.h"
#import "SourceEngineInterface.h"
#import "SearchInfo.h"

@interface SearchViewOfCategoryController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//搜索框属性
@property(nonatomic,strong)UISearchBar* searchBar;

//热门搜索词的label
@property(nonatomic,strong)UILabel* trendWordsLabel;

//热门搜索的关键词用collectionview来表示
@property(nonatomic,strong)UICollectionView* collectionView;

//热门关键词的数据array
@property(nonatomic,strong)NSMutableArray* dataArray;

@end

@implementation SearchViewOfCategoryController

//collectioncell的cellIdentifier
static NSString* CellIdentifier = @"UICollectionViewCell";

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initUI];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

//设置界面
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.trendWordsLabel];
    
    //通过engine获得热门搜索词的数据
    self.dataArray = [[[SourceEngineInterface shareInstances] searchPageWithData] mutableCopy];
    
    /*
     
     设置collectionView
     
     */
    
    //设置水平滚动
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置collectionView的位置
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SEARCHCOLLECTION_X,SEARCHCOLLECTION_Y,SEARCHCOLLECTION_WIDTH,SEARCHCOLLECTION_HEIGHT) collectionViewLayout:flowLayout];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:self.collectionView];
}

//延时加载搜索框
-(UISearchBar*)searchBar{
    if(_searchBar == nil){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(SEARCHBAR_X, SEARCHBAR_Y, SEARCHBAR_WIDTH, SEARCHBAR_HEIGHT)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"大家都在搜";
        //设置搜索结果按钮
        _searchBar.showsSearchResultsButton = YES;
        //设置搜索结果按钮的选中状态
        _searchBar.searchResultsButtonSelected = YES;
        //设置搜索框中光标的颜色
        _searchBar.tintColor = COLOR_RGB(121, 121, 121);
        
    }
    return _searchBar;
}

//延时加载热门搜索词的label
-(UILabel*)trendWordsLabel{
    if(_trendWordsLabel == nil){
        _trendWordsLabel = [[UILabel alloc] initWithFrame:CGRectMake(SEARCHLABEL_X,SEARCHLABEL_Y,SEARCHLABEL_WIDTH,SEARCHLABEL_HEIGHT)];
        _trendWordsLabel.text = @"—— 热门搜索词 ——";
        [_trendWordsLabel setTextColor:COLOR_RGB(220, 220, 220)];
        _trendWordsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _trendWordsLabel;
}


#pragma mark - UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//定义展示的section的个数，即一行展示多少个热门搜索词
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    collectionViewCell.backgroundColor = COLOR_RGB(224, 224, 224);
    
    //向cell中添加button
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-2*SEARCHCOLLECTION_X)/4, 60*(SCREEN_WIDTH/SCREEN_HEIGHT))];
    SearchInfo* searchInfo = [[SearchInfo alloc] init];
    searchInfo = (SearchInfo*)[self.dataArray objectAtIndex:indexPath.row];
    [button setTitle:searchInfo.trendWord forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    //添加事件监听
    [button addTarget:self action:@selector(trendWordsClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [collectionViewCell addSubview:button];
    
    return collectionViewCell;
}

//实现热门搜索词汇的按钮的事件
-(void)trendWordsClicked:(id)sender{
    if(sender && [sender isKindOfClass:[UIButton class]]){
        
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个item的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-2*SEARCHCOLLECTION_X)/4, 60*(SCREEN_WIDTH/SCREEN_HEIGHT));
}

//定义每个UICollectionView 的 边缘
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   return UIEdgeInsetsMake(40*(SCREEN_WIDTH/SCREEN_HEIGHT), 20*(SCREEN_WIDTH/SCREEN_HEIGHT), 20*(SCREEN_WIDTH/SCREEN_HEIGHT), 20*(SCREEN_WIDTH/SCREEN_HEIGHT));
}

@end
