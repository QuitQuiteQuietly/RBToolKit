//
//  QRScanViewController.m
//  RBToolKit_Example
//
//  Created by Ray on 2018/5/31.
//  Copyright © 2018年 wzc5670594. All rights reserved.
//

#import "QRScanViewController.h"

#import <RBToolKit/RB_QRScan.h>

#import <ReactiveObjC/ReactiveObjC.h>

#import <RBToolKit/QRScanView.h>

@interface QRScanViewController ()
/**  */
@end

@implementation QRScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    QRScanView *view = [[QRScanView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];
    
    @weakify(self)
    [[RB_QRScan scan] getReady:^(AVCaptureVideoPreviewLayer *layer) {
        @strongify(self)
        [self.view.layer insertSublayer:layer atIndex:0];
    }];
    
    [[[RB_QRScan scan].flashOn takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"fasdgsafds%@", x);
    }];

    [RB_QRScan scan].sessionStatus = self.rac_willDeallocSignal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
