//
//  URLDownloadingOperation.h
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "BaseOperation.h"

@interface URLDownloadingOperation : BaseOperation

@property (copy, nonatomic) NSURL *URL;
@property (readonly, copy, nonatomic) NSData *data;

+ (instancetype)operationWithURL:(NSURL *)URL;

@end
