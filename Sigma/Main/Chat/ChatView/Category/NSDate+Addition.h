//
//  NSDate+Addition.h
//  KeyBoardView
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (Addition)

+ (NSDate *)dateString:(NSString *)dateString WithFormate:(NSString *)formate;
+ (CGFloat)timeIntervalWithFormer:(NSDate *)former latter:(NSDate *)latter;
+ (NSString *)date:(NSDate *)date WithFormate:(NSString *)formate;

@end
