//
//  CacheManagement.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "CacheManagement.h"
#import "AppDelegate.h"
#import "HUDManager.h"

@interface CacheManagement ()

//@property (strong, nonatomic) NSString *calculateCacheSize;
//@property (weak, nonatomic) IBOutlet UITableViewCell *clearCacheCell;

@end

@implementation CacheManagement

//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    [self calculateCacheSize];
//}

+ (NSString*)calculateCacheSize {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *cachePath = [[[AppDelegate sharedDelegate] applicationCachesDirectory].absoluteString substringFromIndex:5];
        
        __block NSUInteger totalSize = 0;
        
        [[fileManager subpathsOfDirectoryAtPath:cachePath error:nil] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            totalSize += [[fileManager attributesOfItemAtPath:[cachePath stringByAppendingPathComponent:obj] error:nil] fileSize];
        }];
        
        NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
        NSString *result = [formatter stringFromByteCount:totalSize];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.cacheSizeLabel.text = result;
            NSLog(@"%@",result);
//        });
//    });
    return result;
}

+ (void)clearCache {
//    dispatch_async(dispatch_get_main_queue(), ^{
        [[HUDManager defaultManager] showProgressWithString:@"正在清理"];
//    });
    
    NSString *cachePath = [[[AppDelegate sharedDelegate] applicationCachesDirectory].absoluteString substringFromIndex:5];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
    
    // 等待一秒，让用户感觉清理了许多垃圾......
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HUDManager defaultManager] hideProgress];
        [[HUDManager defaultManager] showToastWithString:@"缓存已经全部清空。"];
//        [self.navigationController popViewControllerAnimated:YES];
    });
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([tableView cellForRowAtIndexPath:indexPath] == self.clearCacheCell) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self clearCache];
//        });
//    }
//}

@end
