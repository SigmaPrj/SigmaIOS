//
//  SACommentView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/27.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SACommentView.h"
#import "SAFooterLoadingView.h"
#import "SACommentModel.h"
#import "SACommentFrameModel.h"
#import "SACommentSectionView.h"
#import "SACommentCell.h"

#define COMMENT_VIEW_SECTION_HEIGHT 38

@interface SACommentView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SAFooterLoadingView *footerLoadingView;

@property (nonatomic, strong) NSMutableArray* datas;

@property (nonatomic, strong) SACommentSectionView *sectionView;

@end

@implementation SACommentView

- (instancetype)initWithHeaderView:(UIView *)headerView frame:(CGRect)frame {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        self.tableHeaderView = headerView;
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0)];
//        [footerView addSubview:self.footerLoadingView];
//        self.tableFooterView = footerView;

        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setCommentsData:(NSArray *)commentsData {
    for (int i = 0; i < commentsData.count; ++i) {
        SACommentModel *commentModel = [SACommentModel commentWithDict:commentsData[(NSUInteger)i]];
        SACommentFrameModel *frameModel = [[SACommentFrameModel alloc] init];
        frameModel.commentModel = commentModel;
        [self.datas addObject:frameModel];
    }

    if ([self.ownDelegate respondsToSelector:@selector(addDataSuccess:commentsData:)]) {
        [self.ownDelegate addDataSuccess:self commentsData:self.datas];
    }

    [self reloadData];
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (SAFooterLoadingView *)footerLoadingView {
    if (!_footerLoadingView) {
        _footerLoadingView = [[SAFooterLoadingView alloc] initWithFrame:CGRectMake(0, 0, WIDTH(self), FOOTER_VIEW_LOADING_HEIGHT)];
    }
    return _footerLoadingView;
}

- (SACommentSectionView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[SACommentSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, COMMENT_VIEW_SECTION_HEIGHT)];
    }
    return _sectionView;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected? [cell setSelected:NO]:[cell setSelected:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SACommentFrameModel *frameModel = self.datas[(NSUInteger)indexPath.row];
    return [frameModel getTotalHeight];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEIGHT(self.sectionView);
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"CellComment";

    SACommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[SACommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.frameModel = self.datas[(NSUInteger)indexPath.row];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
