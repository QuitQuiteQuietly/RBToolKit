//
//  QRScanViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/6/1.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "QRScanViewController.h"

@interface QRScanViewController ()

@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanSomething = ^(NSString *result, BOOL *stop) {
        NSLog(@"%@", result);
    };

}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    self.navigationController.navigationBar.translucent = YES;
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = NO;
//    
//}


@end
