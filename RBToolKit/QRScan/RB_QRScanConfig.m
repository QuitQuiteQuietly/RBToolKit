//
//  RB_QRScanConfig.m
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import "RB_QRScanConfig.h"

#import "ReactiveObjC.h"

@implementation RB_QRScanConfig


+ (RB_QRScanConfig *)config {
    RB_QRScanConfig *c = [RB_QRScanConfig new];
    c.view = [QRScanViewConfig config];
    c.albumManage = YES;
    return c;
}



@end


@implementation QRScanViewConfig

+ (QRScanViewConfig *)config {
    QRScanViewConfig *c = [QRScanViewConfig new];
    c.lineWidth = 2;
    c.lineColor = [UIColor whiteColor];
    c.lineLength = 20;
    c.maskBoxBoardWidth = .2;
    c.maskBoxBoardColor = [UIColor whiteColor];
    c.scanLine_display = YES;
    c.flashNotice = [RACTuple tupleWithObjects:@"轻触照亮", @"轻触关闭", nil];
    return c;
}


@end
