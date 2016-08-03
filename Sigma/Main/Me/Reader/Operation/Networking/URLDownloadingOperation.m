//
//  URLDownloadingOperation.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "URLDownloadingOperation.h"

@interface URLDownloadingOperation ()

@property (readwrite, copy, nonatomic) NSData *data;
@property (strong, nonatomic) NSURLSessionDataTask *task;

@end

@implementation URLDownloadingOperation

+ (instancetype)operationWithURL:(NSURL *)URL {
    URLDownloadingOperation *op = [[URLDownloadingOperation alloc] init];
    op.URL = URL;
    
    return op;
}

- (void)executeMain {
    __weak typeof(URLDownloadingOperation) *weakSelf = self;
    
    //配置会话的属性，可以通过该类配置会话的工作模式
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 3.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    self.task = [session dataTaskWithURL:self.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [weakSelf finishWithError:error];
        } else {
            weakSelf.data = data;
            [weakSelf finish];
        }
    }];
    
    [self.task resume];
}

- (void)cancel {
    [self.task cancel];
    
    [super cancel];
}

@end
