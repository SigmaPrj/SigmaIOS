//
//  BlockOperation.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "BaseOperation.h"

@interface BlockOperation : BaseOperation

@property (assign, nonatomic) dispatch_queue_t dispatchQueue;
@property (copy, nonatomic) void(^block)();

+ (instancetype)mainQueueOperationWithBlock:(void(^)())block;
+ (instancetype)globalQueueOperationWithBlock:(void(^)())block;

@end
