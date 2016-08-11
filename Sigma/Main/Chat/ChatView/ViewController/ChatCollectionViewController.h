//
//  ChatCollectionViewController.h
//  KeyBoardView
//
//

#import <UIKit/UIKit.h>

@interface ChatCollectionViewController : UIViewController

- (void)setLeftUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar nickname:(NSString *)nickname;
- (void)setRightUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar nickname:(NSString *)nickname;

@end
