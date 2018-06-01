//
//  QRScanView.h
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import <UIKit/UIKit.h>


@class QRScanViewConfig;

@interface QRScanView : UIView

+ (QRScanView *)frame:(CGRect)frame config:(QRScanViewConfig *)config;

@end


@interface QRScanViewConfig : NSObject

+ (QRScanViewConfig *)config;

/**  */
@property (nonatomic, strong)UIColor *maskBoxBoardColor;
@property (nonatomic, assign)CGFloat maskBoxBoardWidth;

/**  */
@property (nonatomic, strong)UIColor *lineColor;
/**  */
@property (nonatomic, assign)CGFloat lineWidth;
/**  */
@property (nonatomic, assign)CGFloat lineLength;

/** 扫描线 */
@property (nonatomic, strong)UIImage *scanLineImage;
/** 是否需要扫描线 */
@property (nonatomic, assign)BOOL scanLine_display;

@end
