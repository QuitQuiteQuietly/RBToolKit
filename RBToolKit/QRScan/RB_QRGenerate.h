//
//  RB_QRGenerate.h
//  MJRefresh
//
//  Created by Ray on 2018/5/31.
//

#import <UIKit/UIKit.h>


 /**
 
 * Inspire by kingsic/SGQRCode
 
 * https://github.com/kingsic/SGQRCode
 
 */



@interface RB_QRGenerate : NSObject


+ (UIImage *)qr_info:(NSString *)info width:(CGFloat)width;


@end
