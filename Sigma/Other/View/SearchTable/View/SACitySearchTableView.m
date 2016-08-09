//
//  SACitySearchTableView.m
//  Sigma
//
//  Created by 汤轶侬 on 16/8/8.
//  Copyright (c) 2016 sigma. All rights reserved.
//

#import "SACitySearchTableView.h"

@interface SACitySearchTableView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *cities;

@end

@implementation SACitySearchTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {

        self.delegate = self;
        self.dataSource = self;

        [self setupData];
    }
    return self;
}

- (void)setupData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
    self.cities = [NSMutableArray arrayWithContentsOfFile:filePath];
}

- (NSMutableArray *)cities {
    if (!_cities) {
        _cities = [NSMutableArray array];
    }
    return _cities;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:!cell.isSelected];

    if ([self.ownDelegate respondsToSelector:@selector(cityCellDidClicked:cell:)]) {
        [self.ownDelegate cityCellDidClicked:self cell:cell];
    }

    [self removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dict = self.cities[(NSUInteger)section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    UILabel *uiLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
    uiLabel.font = [UIFont systemFontOfSize:17];
    uiLabel.text = dict[@"group"];
    uiLabel.textColor = SIGMA_FONT_COLOR;
    [view addSubview:uiLabel];
    return view;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dict = self.cities[(NSUInteger)section];
    NSArray *cities = dict[@"cities"];
    return cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CityCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    NSDictionary *dict = self.cities[(NSUInteger)indexPath.section];
    NSArray *cities = dict[@"cities"];
    NSDictionary *city = cities[(NSUInteger)indexPath.row];

    cell.textLabel.text = city[@"name"];
    cell.tag = [city[@"code"] intValue];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cities.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.cities.count; ++i) {
        [array addObject:self.cities[(NSUInteger)i][@"group"]];
    }
    return [array copy];
}

@end
