//
//  RB_QRScanView.h
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import <UIKit/UIKit.h>


@class QRScanViewConfig;

@class RACSignal;
@class RACTuple;

@interface RB_QRScanView : UIView

+ (RB_QRScanView *)frame:(CGRect)frame config:(QRScanViewConfig *)config;

/** 是否需要开启手电筒 */
@property (nonatomic, strong)RACSignal *needFlash;

@end



