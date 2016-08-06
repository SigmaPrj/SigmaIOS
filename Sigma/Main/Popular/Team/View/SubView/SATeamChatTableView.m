//
//  SATeamChatTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/5.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SATeamChatTableView.h"
#import "SAMessageModel.h"
#import "SAChatModel.h"
#import "SAChatFrameModel.h"
#import "SAChatCell.h"

@interface SATeamChatTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation SATeamChatTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.allowsSelection = NO;

        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setDatas:(NSArray *)array {
    for (int i = 0; i < array.count; ++i) {
        SAChatModel *chatModel = [SAChatModel chatWthDict:array[(NSUInteger)i]];
        SAChatFrameModel *frameModel = [[SAChatFrameModel alloc] init];
        frameModel.chatModel = chatModel;
        frameModel.messageModel = self.messageModel;
        [self.messages addObject:frameModel];
    }

    [self reloadData];
}

- (NSMutableArray *)messages {
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAChatFrameModel *chatFrameModel = self.messages[(NSUInteger)indexPath.row];
    return [chatFrameModel getTotalHeight];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ChatCell";

    SAChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[SAChatCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    cell.frameModel = self.messages[(NSUInteger)(indexPath.row)];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


@end
