//
//  QRViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/31.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "QRViewController.h"

#import <RBToolKit/RB_QRGenerate.h>

#import "QRScanViewController.h"

@interface QRViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *qr_imageView;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _qr_imageView.image = [RB_QRGenerate qr_info:@"RBToolKit" width:CGRectGetWidth(_qr_imageView.frame)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"扫一扫"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];

    self.navigationItem.rightBarButtonItem = item;
}

- (void)scan {
    
    QRScanViewController *vc = [QRScanViewController scan:nil album:^(UIBarButtonItem *item) {
        item.title = @"选择照片";
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
