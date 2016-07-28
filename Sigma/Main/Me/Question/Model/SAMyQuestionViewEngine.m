//
//  SAQuestionViewEngine.m
//  Sigma
//
//  Created by Ace Hsieh on 7/27/16.
//  Copyright © 2016 blackcater. All rights reserved.
//

#import "SAMyQuestionViewEngine.h"

#import "SAMyQuestionCell.h"

@interface SAMyQuestionViewEngine()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SAMyQuestionViewEngine

+(instancetype)shareInstance{
    static SAMyQuestionViewEngine *instance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[SAMyQuestionViewEngine alloc]init];
    });
    return instance;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        _dataArray=[[NSMutableArray alloc]init];
        
        [self questionInitDataSection:nil];
    }
    return self;
}

-(NSArray*)dataSection{
    return self.dataArray;
}

-(void)questionInitDataSection:(NSDictionary*)list{
    [_dataArray addObject:[[SAMyQuestionCell alloc]initWithTitle:@"hhhhhhhhhhhhhhh？" andDetail:@"[一万小时定律]并非适合所有领域，即使有很强意志力，也很难在3到4个领域成为世界顶级。问题回答完毕，以下是解释。[一万小时定律]怎么回事：首先需要说明的是，这个10000不是确数，不是说你得不多不少正好10000小时。大约可以理解成平均需要10000小时。" andHeadImageName:@"Head_Img_Of_HeaderView" andPopularity:@"1000"]];
    [_dataArray addObject:[[SAMyQuestionCell alloc]initWithTitle:@"[二万小时定律]真的适合所有领域吗？" andDetail:@"[二万小时定律]并非适合所有领域，即使有很强意志力，也很难在3到4个领域成为世界顶级。问题回答完毕，以下是解释。[一万小时定律]怎么回事：首先需要说明的是，这个10000不是确数，不是说你得不多不少正好10000小时。大约可以理解成平均需要10000小时。" andHeadImageName:@"Head_Img_Of_HeaderView" andPopularity:@"222"]];
    
}

@end
