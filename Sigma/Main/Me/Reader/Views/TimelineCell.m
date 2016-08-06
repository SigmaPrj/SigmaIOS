//
//  TimelineCell.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "TimelineCell.h"
#import "OperationQueue.h"
#import "ImageDownloadingOperation.h"

@interface TimelineCell ()

@property (strong, nonatomic) ImageDownloadingOperation *currentDownloadingOperation;

@end

@implementation TimelineCell


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
//        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    } else {
        [super setHighlighted:highlighted animated:YES];
    }
}

- (UILabel *)textLabel {
    return [self viewWithTag:1];
}

- (UIImageView *)imageView {
    return [self viewWithTag:2];
}

- (void)loadWithStory:(Story *)story {
    self.textLabel.text = story.title;
    self.imageView.image = nil;
    
    if (self.currentDownloadingOperation) {
        [self.currentDownloadingOperation cancel];
    }
    
    self.currentDownloadingOperation = [ImageDownloadingOperation operationWithURL:story.imageURL forImageView:self.imageView];
    
    [[OperationQueue globalQueue] addOperation:self.currentDownloadingOperation];
}

@end
