//
//  SourceCommonDefine.h
//  Sigma
//
//  Created by 韩佳成 on 16/7/14.
//  Copyright © 2016年 Terence. All rights reserved.
//

#ifndef SourceCommonDefine_h
#define SourceCommonDefine_h

//定义source界面headview的高度
#define HEADVIEW_HEIGHT 220*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义UICollectionViewCell的个数
#define CELL_NUM 5

//定义section的个数
#define SECTION_NUM 1

//定义UICollectionViewDelegateFlowLayout每个item的大小
#define ITEM_WIDTH (SCREEN_WIDTH-30*(SCREEN_WIDTH/SCREEN_HEIGHT))/2
#define ITEM_HEIGHT 150*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义UICollectionView 的 边缘的参数
#define COLLECTIONVIEW_TOP 20*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define COLLECTIONVIEW_LEft 10*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define COLLECTIONVIEW_BOTTOM 10*(SCREEN_WIDTH/SCREEN_HEIGHT)
#define COLLECTIONVIEW_RIGHT 10*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义source界面中的cell的高度
#define CELL_HEIGHT 260*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义category界面中headview的高度
#define CATEGORYHEAD_HEIGHT 80*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义category界面中headview里面textfield左上角的横坐标
#define CATEGORYTEXTF_LEFT 35*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义category界面中headview里面textfield左上角的纵坐标
#define CATEGORYTEXTF_LEFTY 30*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义category界面中headview里面textfield的高度
#define CATEGORYTEXTF_HEIGHT 48*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义category界面中headview里面textfield边框的宽度
#define CATEGORYTEXTF_BORDERWIDTH 2.0f

//定义category界面中headview里面textfield椭圆的弧度
#define CATEGORYTEXTF_CORNERRADIUS 8

//定义search界面，searchbar的横坐标
#define SEARCHBAR_X 20*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，searchbar的宽度
#define SEARCHBAR_WIDTH SCREEN_WIDTH-2*SEARCHBAR_X

//定义search界面，searchbar的高度
#define SEARCHBAR_HEIGHT 48*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，searchbar的纵坐标
#define SEARCHBAR_Y 160*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门搜索词的label的横坐标
#define SEARCHLABEL_X SCREEN_WIDTH/2-200*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门搜索词的label的纵坐标
#define SEARCHLABEL_Y 248*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门搜索词的label的宽度
#define SEARCHLABEL_WIDTH 400*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门搜索词的label的高度
#define SEARCHLABEL_HEIGHT 48*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门关键词collectionView的横坐标
#define SEARCHCOLLECTION_X 40*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门关键词collectionView的纵坐标
#define SEARCHCOLLECTION_Y 336*(SCREEN_WIDTH/SCREEN_HEIGHT)

//定义search界面，热门关键词collectionView的宽度
#define SEARCHCOLLECTION_WIDTH SCREEN_WIDTH-2*SEARCHCOLLECTION_X

//定义search界面，热门关键词collectionView的高度
#define SEARCHCOLLECTION_HEIGHT SCREEN_HEIGHT-SEARCHCOLLECTION_Y

//定义contentOfSource界面headview的高度
#define CONTENTOFSOURCEHEAD_HE 520*(SCREEN_WIDTH/SCREEN_HEIGHT)


#endif /* SourceCommonDefine_h */
