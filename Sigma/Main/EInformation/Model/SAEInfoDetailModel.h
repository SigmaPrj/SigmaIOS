//
//  SAEInfoDetailModel.h
//  Sigma
//
//  Created by Terence on 16/7/26.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEInfoDetailModel : NSObject

@property(nonatomic, copy) NSString* headImgName;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, copy) NSDate* applyDate;
@property(nonatomic, copy) NSDate* agendaDate;
@property(nonatomic, copy) NSString* mainSponsor;
@property(nonatomic, copy) NSString* secSponsor;
@property(nonatomic, assign) int collctionNum;

@property(nonatomic, copy) NSString* competitionDetail;
@property(nonatomic, copy) NSString* competitionParticipant;
@property(nonatomic, copy) NSString* awardsType;

// 这里应该还要有报名的规则，比如是否允许个人参赛，是否要组队，以及是否有导师




// 对象方法，初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
// 类方法初始化
+ (instancetype)einformationModelWithDict:(NSDictionary *)dict;

@end
