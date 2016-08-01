//
//  SACommentSectionView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/7/28.
//  Copyright (c) 2016 blackcater. All rights reserved.
//

#import "SACommentSectionView.h"

#define COMMENT_WRITE_COMMENT_PADDING 3
#define COMMENT_WRITE_COMMENT_CORNER 4
#define COMMENT_WRITE_COMMENT_BGCOLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]
#define COMMENT_WRITE_COMMENT_BORDER_COLOR [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00]

@interface SACommentSectionView()

@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation SACommentSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COMMENT_WRITE_COMMENT_BGCOLOR;
        [self addSubview:self.commentBtn];
    }
    return self;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setBackgroundColor:[UIColor whiteColor]];
        [_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"comment-active"] forState:UIControlStateHighlighted];
        [_commentBtn setTitle:@"写评论" forState:UIControlStateNormal];
        [_commentBtn setTintColor:COMMENT_WRITE_COMMENT_BORDER_COLOR];
        [_commentBtn setTitleColor:COMMENT_WRITE_COMMENT_BORDER_COLOR forState:UIControlStateNormal];
        [_commentBtn setTitleColor:COMMENT_WRITE_COMMENT_BORDER_COLOR forState:UIControlStateHighlighted];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:COMMENT_COMMENT_FONT_SIZE];

        _commentBtn.layer.cornerRadius =COMMENT_WRITE_COMMENT_CORNER;
        _commentBtn.layer.borderWidth = 1;
        _commentBtn.layer.borderColor = COMMENT_WRITE_COMMENT_BORDER_COLOR.CGColor;

        CGFloat commentX = COMMENT_CELL_PADDING;
        CGFloat commentY = COMMENT_WRITE_COMMENT_PADDING;
        CGFloat commentW = Width(self.frame) -  2*COMMENT_CELL_PADDING;
        CGFloat commentH = Height(self.frame) - 2*COMMENT_WRITE_COMMENT_PADDING;
        _commentBtn.frame = CGRectMake(commentX, commentY, commentW, commentH);
    }
    return _commentBtn;
}

@end
