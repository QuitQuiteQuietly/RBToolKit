//
//  QRViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/31.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "QRViewController.h"

#import <RBToolKit/QRGenerate.h>

#import <RBToolKit/RB_QRScanViewController.h>

@interface QRViewController ()

/**  */
@property (nonatomic, weak)IBOutlet UIImageView *qr_imageView;

@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _qr_imageView.image = [QRGenerate qr_info:@"wzc5670594" width:CGRectGetWidth(_qr_imageView.frame)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"扫一扫"] style:UIBarButtonItemStylePlain target:self action:@selector(scan)];

    self.navigationItem.rightBarButtonItem = item;
}

- (void)scan {
    
    [self.navigationController pushViewController:[RB_QRScanViewController new] animated:YES];
    
}


@end
