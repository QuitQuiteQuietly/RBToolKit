//
//  RB_QRScanConfig.h
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import <Foundation/Foundation.h>

@class QRScanViewConfig;

@class RACTuple;

@interface RB_QRScanConfig : NSObject


+ (RB_QRScanConfig *)config;

/** view */
@property (nonatomic, strong)QRScanViewConfig *view;

/**  */
@property (nonatomic, assign)BOOL albumManage;

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

/** (轻触照亮，轻触关闭) */
@property (nonatomic, strong)RACTuple *flashNotice;

@end
