//
//  TimelineDataSource.m
//  Sigma
//
//  Created by Ace Hsieh on 8/2/16.
//  Copyright © 2016 Terence. All rights reserved.
//

#import "TimelineDataSource.h"
#import "TimelineCell.h"

@interface TimelineDataSource ()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation TimelineDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.formatter = [[NSDateFormatter alloc] init];
        self.formatter.dateFormat = @"yyyy年MM月dd日";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.timelines) {
        return 0;
    }
    return self.timelines.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.timelines) {
        return 0;
    }    
    return (self.timelines)[section].stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    [((TimelineCell *) cell) loadWithStory:[self storyAtIndexPath:indexPath]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.timelines) {
        return nil;
    }
    
    return [self.formatter stringFromDate:(self.timelines)[section].date];
}

- (Story *)storyAtIndexPath:(NSIndexPath *)indexPath {
    return ((self.timelines)[indexPath.section].stories)[indexPath.row];
}

@end
