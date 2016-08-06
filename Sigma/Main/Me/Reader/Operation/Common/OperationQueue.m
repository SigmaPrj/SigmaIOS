//
//  OperationQueue.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "OperationQueue.h"
#import "BaseOperation.h"

@implementation OperationQueue

+ (instancetype)globalQueue {
    static OperationQueue *GlobalQueue = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        GlobalQueue = [[OperationQueue alloc] init];
    });
    
    return GlobalQueue;
}

- (void)addOperation:(NSOperation *)op {
    if ([op isKindOfClass:[BaseOperation class]]) {
        [((BaseOperation *) op) willEnqueue:self];
    }
    
    [super addOperation:op];
}

@end