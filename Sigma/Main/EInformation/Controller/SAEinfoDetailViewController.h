//
//  SAEinfoDetailViewController.h
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAViewController.h"
#import "SAEInfoDetailModel.h"

@interface SAEinfoDetailViewController : SAViewController


@property(nonatomic, assign) int currectIndex;


@property(nonatomic, strong) NSArray* detailDataArray;

-(instancetype)initWithDetailData:(NSArray*)data index:(int)index;

@end
