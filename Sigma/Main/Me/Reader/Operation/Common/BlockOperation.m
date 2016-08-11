//
//  BlockOperation.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "BlockOperation.h"

@implementation BlockOperation

+ (instancetype)mainQueueOperationWithBlock:(void(^)())block {
    BlockOperation *op = [[BlockOperation alloc] init];
    op.dispatchQueue = dispatch_get_main_queue();
    op.block = block;
    
    return op;
}

+ (instancetype)globalQueueOperationWithBlock:(void(^)())block {
    BlockOperation *op = [[BlockOperation alloc] init];
    op.dispatchQueue = dispatch_get_global_queue(0, 0);
    op.block = block;
    
    return op;
}

- (void)executeMain {
    dispatch_async(self.dispatchQueue, ^{
        self.block();
        [self finish];
    });
}

@end
