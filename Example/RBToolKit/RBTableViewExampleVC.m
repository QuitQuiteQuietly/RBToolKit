//
//  RBTableViewExampleVC.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/13.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBTableViewExampleVC.h"

#import <RBToolKit/RBTableView.h>

#import <ReactiveObjC/ReactiveObjC.h>

@interface RBTableViewExampleVC ()<UITableViewDataSource>

/**  */
@property (nonatomic, weak)IBOutlet RBTableView *tableView;

/**  */
@property (nonatomic, strong)NSMutableArray *array;

@end

@implementation RBTableViewExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
    
    @weakify(self)
    [self.tableView rb_mj_refresh:^(BOOL header, NSInteger page, RBTableView *tableView) {
     @strongify(self)
        if (header) {
            [self.array removeAllObjects];
        }

        [self.array addObjectsFromArray:@[@1, @2, @3, @4, @5]];

        NSLog(@"开始刷新 %ld --- %@", page, header ? @"首页" : @"非首页");

        [tableView endRefreshAndRequestSuccess:YES withNoMoreData:NO isEmpty:NO];

    }].enable(eRBTV_DirFooter | eRBTV_DirHeader).takeWithReset(eRBTV_DirFooter, NO, 2);


    [self.tableView startRefresh];
    
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:[UITableViewCell description]];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    cell.detailTextLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


@end
