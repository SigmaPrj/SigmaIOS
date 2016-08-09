//
//  ParsingOperation.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "ParsingOperation.h"
#import "URLDownloadingOperation.h"

@implementation ParsingOperation

- (NSData *)data {
    __block NSData *inputData = self->_data;
    
    if (!inputData) {
        [self.dependencies enumerateObjectsUsingBlock:^(NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[URLDownloadingOperation class]]) {
                inputData = ((URLDownloadingOperation *) obj).data;
                
                if (inputData) {
                    *stop = YES;
                }
            }
        }];
    }
    
    if (!inputData) {
        [self finishWithError:[NSError errorWithDomain:@"ErrorDomainInvalidParameter" code:1 userInfo:nil]];
        return nil;
    }
    
    return inputData;
}

@end
