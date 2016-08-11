//
//  SourceHeadView.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SourceHeadView.h"
#import "Masonry.h"
#import "SourceCommonDefine.h"
#import "SourceHeadCollectionViewCell.h"

@interface SourceHeadView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView* collectionView;

@end

@implementation SourceHeadView

static NSString* CellIdentifier = @"UICollectionViewCell";

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}


/*
 
 对headview上面的控件进行添加，设置，初始化
 
 */
-(void)initUI{
    
    //设置UICollectionView是水平滚动的还是垂直滚动的
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADVIEW_HEIGHT) collectionViewLayout:flowLayout];
    
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //设置UICollectionView的代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate =self;
    
    [self.collectionView setBackgroundColor:COLOR_RGB(245, 245, 245)];
    
    //注册UICollectionView的cell
    [self.collectionView registerClass:[SourceHeadCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self addSubview:self.collectionView];

}

#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return CELL_NUM;
}

//定义展示的section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return SECTION_NUM;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SourceHeadCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    NSString* imageName = [NSString stringWithFormat:@"Resource%ld.png",indexPath.row+1];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [cell addSubview:imageView];
    
    cell.backgroundColor = COLOR_RGB(242, 242, 242);
    
    //    这个是设置cell后面又一个箭头
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    cell.detailTextLabel.text =  stackData.numOfBook;
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
}

//定义每个UICollectionView 的 边缘
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(COLLECTIONVIEW_TOP, COLLECTIONVIEW_LEft, COLLECTIONVIEW_BOTTOM, COLLECTIONVIEW_RIGHT);
}


@end
