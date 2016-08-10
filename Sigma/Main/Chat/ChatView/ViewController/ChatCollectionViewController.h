//
//  ChatCollectionViewController.h
//  KeyBoardView
//
//

#import <UIKit/UIKit.h>

@interface ChatCollectionViewController : UIViewController

- (void)setLeftUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar;
- (void)setRightUserData:(NSInteger)userId username:(NSString *)username avatar:(NSString *)avatar;

@end
