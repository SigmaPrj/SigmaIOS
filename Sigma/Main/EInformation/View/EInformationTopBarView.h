//
//  EInformationTopBarView.h
//  Sigma
//
//  Created by Terence on 16/7/20.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EInformationTopBarViewDelegate <NSObject>

-(void)btnClickedWithTag:(int)tag;


@end

@interface EInformationTopBarView : UIView

- (instancetype)initWithFrame:(CGRect)frame categoreis:(NSArray *)categories;

@property(nonatomic, weak)id<EInformationTopBarViewDelegate> delegate;

//@property(nonatomic, strong)NSArray* categoryArray;
//
//-(void)addCategories:(NSArray*)categories;

@end
