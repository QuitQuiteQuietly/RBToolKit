//
//  KXColor.h
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import <Foundation/Foundation.h>

@interface RBColor : NSObject

/**
 蓝色
 
 @return 0,135,209-1
 */
+ (UIColor *)color_blue;


/**
 浅蓝
 
 @return 202,225,237-1
 */
+ (UIColor *)color_ligthBlue;


/**
 灰字
 
 @return 169,169,169-1
 */
+ (UIColor *)color_textGray;


/**
 黑字
 
 @return 45,45,45-1
 */
+ (UIColor *)color_textBlack;



/**
 黄字

 @return 246,171,0-1
 */
+ (UIColor *)color_textYellow;


/**
 硬币黄

 @return #f6ab00
 */
+ (UIColor *)color_coinYellow;

+ (UIColor *)color_colorWhite;
+ (UIColor *)color_colorBlack;

/**
 背景灰
 
 @return #eeeeee
 */
+ (UIColor *)color_bg;

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
