
//
//  CourseCommonDefine.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/27.
//  Copyright © 2016年 Terence. All rights reserved.
//

#ifndef CourseCommonDefine_h
#define CourseCommonDefine_h

//定义主页scrollview的图片的数量
#define SCROLLIMAGE_NUM 4

//scrollview的高度，也是headview的高度
#define SCROLL_HEIGHT 300*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义mainpage的cell头的图片的位置属性
#define MAINPAGECELL_Y 10*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGECELL_WIDTH 240*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGECELL_HEIGHT 180*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义mainpage的cell课程名称位置的属性
#define MAINPAGENAMELABEL_X CGRectGetMaxX(self.headImageView.frame)+10*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGENAMELABEL_WIDTH 200*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGENAMELABEL_HEIGHT 60*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义mainpage的cell每个课程学习的数量的位置属性
#define MAINPAGENUMOFSTUDY_X CGRectGetMaxX(self.headImageView.frame)+200*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGENUMOFSTUDY_Y 120*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGENUMOFSTUDY_WIDTH 200*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define MAINPAGENUMOFSTYDY_HEIGHT 60*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义每个cell的高度
#define CELL_HEIGHT 200*(SCREEN_WIDTH/SCREEN_HEIGHT)



#endif /* CourseCommonDefine_h */
