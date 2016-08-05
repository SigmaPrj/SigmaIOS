//
//  SAMyDetailQuestionEngine.m
//  Sigma
//
//  Created by Ace Hsieh on 8/5/16.
//  Copyright © 2016 sigma. All rights reserved.
//

#import "SAMyDetailQuestionEngine.h"
#import "SAMyDetailQuestionData.h"

@interface SAMyDetailQuestionEngine ()

@property (nonatomic, strong)NSMutableArray* questionArray;

@end


@implementation SAMyDetailQuestionEngine


-(instancetype)init{
    self = [super init];
    
    if (self) {
        _questionArray = [NSMutableArray array];
        
        [self homeDetailPageWithArray];
    }
    return self;
}

+(instancetype)shareInstance{
    
    static SAMyDetailQuestionEngine* instances = nil;
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        instances = [[SAMyDetailQuestionEngine alloc] init];
    });
    
    return instances;
    
}

-(NSArray*)homeDetailPageWithData{
    
    return self.questionArray;
    
}

-(SAMyDetailQuestionData*)homeDetailPageDataWithIndex:(int)index{
    
    if (index>=0 && index<self.questionArray.count) {
        return [self.questionArray objectAtIndex:index];
    }else{
        return nil;
    }
    
}

-(void)homeDetailPageWithArray{
    
    NSArray *text = @[@"[一万小时定律]并非适合所有领域，即使有很强意志力，也很难在3到4个领域成为世界顶级。问题回答完毕，以下是解释。[一万小时定律]怎么回事：首先需要说明的是，这个10000不是确数，不是说你得不多不少正好10000小时。大约可以理解成平均需要10000小时。",
                      @"谢@谢竹君 邀，这个问题我简单提一下自己的看法，权当抛砖引玉。作为一个成长中的家具及室内设计师，这个问题我还是很值得关注，思路大概可以有以下几条。1.学会倾听并记录客户的基本诉求，所谓进本诉求，就是说某位客户来找你，“我有一套房子要做婚房，需要在两个月内入住。”",
                      @"作为曾经花费3个月环游贵州，且间断性4年来深入贵州20多次的资深旅游人士。这个问题我来回答太合适了。多图预警......爪机慎入......持续更新中。贵州这片神奇的土地即使旅游局做了相当大努力，大家依然对此表示陌生。每当身边有人咨询外出旅游的事我都推荐贵州。相比香港，三亚的繁杂，张家界，泰山的平庸，以及凤凰，丽江，拉萨的俗气",
                      @"讲一个亲历的小故事2010年，在日本留学的第一年，去一个点心工厂打工了一个月，工资是8万日元，老板一直赖账了半年，始终不给我们。我都对这笔钱不抱希望了。同样被这个老板赖账的还有两个蒙古国女孩。日本语学校的老师帮我们联系老板要帐，始终要不下来。",
                      @"六岁，我妈开药店，中午在店后面午睡，让我看店，我坐在药店门口，就着凉爽的小风，把我妈准备晚饭吃的一只烧鸡，和一瓶雪鹿啤酒（不是易拉罐不是嘉士伯是那种哈啤的大瓶我还是自己开的盖）吃喝的干干净净，我妈一个午觉起来，看见的只有烧鸡的空塑料袋和空啤酒瓶，"];
    
    NSArray *imageName = @[@"resource1",@"resource2",@"resource3",
                           @"resource4",@"resource5"];
    
    for (int index = 0; index < text.count; index++) {
        SAMyDetailQuestionData* qd = [[SAMyDetailQuestionData alloc] init];
        qd.imageName = [imageName objectAtIndex:index];
        qd.text = [text objectAtIndex:index];
        
        [_questionArray addObject:qd];
    }
    
}

@end
