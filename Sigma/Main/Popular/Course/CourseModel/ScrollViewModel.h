//
//  ScrollViewModel.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollViewModel : NSObject

//图片名称
@property(nonatomic,copy)NSString* imageName;

-(instancetype)initWithDictionary:(NSDictionary*)dic;

@end
