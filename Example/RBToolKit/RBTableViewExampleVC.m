//
//  RBTableViewExampleVC.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/13.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "RBTableViewExampleVC.h"

#import <RBToolKit/RBTableView.h>

@interface RBTableViewExampleVC ()<UITableViewDataSource>

/**  */
@property (nonatomic, weak)IBOutlet RBTableView *tableView;

@end

@implementation RBTableViewExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell description]];
    
    [self.tableView rb_mj_refresh:^(BOOL header, NSInteger page, RBTableView *tableView) {
     
        NSLog(@"开始刷新 %ld --- %@", page, header ? @"首页" : @"非首页");
     
        [tableView endRefresh:YES];
        
    } enableHeader:YES footer:YES];
    
    
    [self.tableView startRefresh];
    
}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description] forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell description]];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


@end
