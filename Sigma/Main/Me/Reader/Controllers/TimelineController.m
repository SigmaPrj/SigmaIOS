//
//  TimelineController.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "TimelineController.h"
#import "OperationQueue.h"
#import "URLDownloadingOperation.h"
#import "TimelineParsingOperation.h"
#import "BlockOperation.h"

@interface TimelineController ()

@property (readwrite, strong, nonatomic) NSMutableArray<Timeline *> *internalTimelines;
@property (readwrite, assign, nonatomic) BOOL busy;

@end

@implementation TimelineController

- (NSArray<Timeline *> *)timelines {
    return [self.internalTimelines copy];
}

- (void)reload {
    if (self.busy)
        return;
    
    if (!self.internalTimelines) {
        self.internalTimelines = [[NSMutableArray alloc] init];
    }
    
    self.busy = YES;
    
    URLDownloadingOperation *downloadOp = [URLDownloadingOperation operationWithURL:[NSURL URLWithString:@"http://news-at.zhihu.com/api/4/news/latest"]];
//    https://www.zhihu.com/topic/19616946/top-answers
//    http://news-at.zhihu.com/api/4/news/latest
    TimelineParsingOperation *parsingOp = [[TimelineParsingOperation alloc] init];
    BlockOperation *notifyOp = [BlockOperation mainQueueOperationWithBlock:^{
        if (parsingOp.timeline) {
            if (![(self.internalTimelines).firstObject.date isEqualToDate:parsingOp.timeline.date]) {
                [self.internalTimelines removeAllObjects];
                [self.internalTimelines addObject:parsingOp.timeline];
            } else {
                [self.internalTimelines setObject:parsingOp.timeline atIndexedSubscript:0];
            }
            [self.delegate timelineControllerDidFinishLoading:self];
        } else {
            [self.delegate timelineControllerDidFailedLoading:self];
        }
        
        self.busy = NO;
    }];
    
    [parsingOp addDependency:downloadOp];
    [notifyOp addDependency:parsingOp];
    
    [[OperationQueue globalQueue] addOperation:downloadOp];
    [[OperationQueue globalQueue] addOperation:parsingOp];
    [[OperationQueue globalQueue] addOperation:notifyOp];
}

- (void)reserve {
    if (self.busy)
        return;
    
    self.busy = YES;
    
    URLDownloadingOperation *downloadOp = [URLDownloadingOperation operationWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/%@", (self.timelines).lastObject.dateString]]];
    TimelineParsingOperation *parsingOp = [[TimelineParsingOperation alloc] init];
    BlockOperation *notifyOp = [BlockOperation mainQueueOperationWithBlock:^{
        if (parsingOp.timeline) {
            [self.internalTimelines addObject:parsingOp.timeline];
            [self.delegate timelineControllerDidFinishLoading:self];
        } else {
            //无法获取最新消息，请检查网络设置
            [self.delegate timelineControllerDidFailedLoading:self];
        }
        
        self.busy = NO;
    }];
    
    [parsingOp addDependency:downloadOp];
    [notifyOp addDependency:parsingOp];
    
    [[OperationQueue globalQueue] addOperation:downloadOp];
    [[OperationQueue globalQueue] addOperation:parsingOp];
    [[OperationQueue globalQueue] addOperation:notifyOp];
}

@end
