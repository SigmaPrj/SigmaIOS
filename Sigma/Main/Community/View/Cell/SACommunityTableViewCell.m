//
//  SACommunityTableViewCell.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "SACommunityTableViewCell.h"
#import "SACommunityTableViewCellFooter.h"

@interface SACommunityTableViewCell()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *schoolLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UIImageView *approvedImageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) SACommunityTableViewCellFooter *footerView; // 代理 处理点击事件

@end

@implementation SACommunityTableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self render];
    }
    
    return self;
}


- (void)render {
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
