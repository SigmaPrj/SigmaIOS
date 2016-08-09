//
//  TimelineSectionHeaderView.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "TimelineSectionHeaderView.h"

@interface TimelineSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;

@end

@implementation TimelineSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
