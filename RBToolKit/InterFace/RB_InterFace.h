//
//  KXInterFace.h
//  KXDoctor
//
//  Created by Ray on 2017/9/23.
//  Copyright © 2017年 Peak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RB_InterFace : NSObject


/**
 富文本字符串属性

 @param fontSize 字体大小
 @param color 颜色
 @return NSForegroundColorAttributeName : UIColor, NSFontAttributeName : UIFont
 */
+ (NSDictionary *)attributedDictionary:(CGFloat)fontSize color:(UIColor *)color;


@end
