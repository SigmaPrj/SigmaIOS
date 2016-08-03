//
//  SACommunityTableView.h
//  Sigma
//

#import <UIKit/UIKit.h>
#import "SALoadingTableView.h"

@class SADynamicModel;

@protocol SACommunityTableViewDelegate<NSObject>

@required
- (void)commentBtnDidClicked:(NSInteger)dynamic_id dynamicModel:(SADynamicModel *)dynamicModel;

@end

@interface SACommunityTableView : SALoadingTableView

@property (nonatomic, weak) id<SACommunityTableViewDelegate> ownDelegate;

- (void)setHeaderData:(NSDictionary *)dict;

- (void)setDynamicData:(NSArray *)dynamicArray;

- (void)stopLoading;

@end
