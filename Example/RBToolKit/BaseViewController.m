//
//  BaseViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/31.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)dealloc {
    NSLog(@"-- dealloc -- %@ --", self);
}

@end
