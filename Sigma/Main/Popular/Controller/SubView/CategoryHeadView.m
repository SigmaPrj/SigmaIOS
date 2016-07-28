//
//  CategoryHeadView.m
//  Sigma
//
//  Created by 韩佳成 on 16/7/19.
//  Copyright © 2016年 Terence. All rights reserved.
//

#import "CategoryHeadView.h"
#import "SourceCommonDefine.h"


@interface CategoryHeadView()<UISearchBarDelegate>

@property(nonatomic,strong)UITextField* searchTextField;

//搜索框属性
@property(nonatomic,strong)UISearchBar* searchBar;

@end

@implementation CategoryHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
//    [self addSubview:self.searchTextField];
    [self addSubview:self.searchBar];
    
}

//延时加载搜索框
-(UISearchBar*)searchBar{
    if(_searchBar == nil){
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CATEGORYTEXTF_LEFT, CATEGORYTEXTF_LEFTY, SCREEN_WIDTH-CATEGORYTEXTF_LEFT*2,CATEGORYTEXTF_HEIGHT)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"大家都在搜";
        //设置搜索结果按钮
        _searchBar.showsSearchResultsButton = YES;
        //设置搜索结果按钮的选中状态
        _searchBar.searchResultsButtonSelected = YES;
        //设置搜索框中光标的颜色
        _searchBar.tintColor = COLOR_RGB(121, 121, 121);
        
        //设置代理
        _searchBar.delegate = self;
    }
    return _searchBar;
}

//延时加载TextFieldreturn _searchTextField
-(UITextField*)searchTextField{
    if(_searchTextField == nil){
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(CATEGORYTEXTF_LEFT, CATEGORYTEXTF_LEFTY, SCREEN_WIDTH-CATEGORYTEXTF_LEFT*2,CATEGORYTEXTF_HEIGHT)];
        _searchTextField.layer.borderWidth = CATEGORYTEXTF_BORDERWIDTH;
        _searchTextField.layer.cornerRadius = CATEGORYTEXTF_CORNERRADIUS;
        _searchTextField.layer.borderColor = [COLOR_RGB(204, 204, 204) CGColor];
        _searchTextField.keyboardType = UIKeyboardTypeDefault;
        
        
        
    }
    return _searchTextField;
}

//searchbar的代理
#pragma mark - UISearchBarDelegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}

@end
