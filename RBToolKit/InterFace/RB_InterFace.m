//
//  KXInterFace.m
//  KXDoctor
//
//  Created by Ray on 2017/9/23.
//  Copyright © 2017年 Peak. All rights reserved.
//

#import "RB_InterFace.h"

@implementation RB_InterFace

//#define KXColorBlue [UIColor colorWithRed:0.0/255.0f green:135.0/255.0f blue:209.0/255.0f alpha:1]
//#define KXColorLightBlue [UIColor colorWithRed:202.0/255.0f green:225.0/255.0f blue:237.0/255.0f alpha:1]
//#define KXColorSkyBlue [UIColor colorWithRed:238.0/255.0f green:244.0/255.0f blue:247.0/255.0f alpha:1]
//#define KXColorYellow [UIColor colorWithRed:246.0/255.0f green:171.0/255.0f blue:0.0/255.0f alpha:1]
//#define KXColorTextBlack [UIColor colorWithRed:45.0/255.0f green:45.0/255.0f blue:45.0/255.0f alpha:1]
//#define KXColorTextGray [UIColor colorWithRed:169.0/255.0f green:169.0/255.0f blue:169.0/255.0f alpha:1]
//#define KXColorTextLightGray [UIColor colorWithRed:214.0/255.0f green:214.0/255.0f blue:214.0/255.0f alpha:1]
////#define KXColorBg [UIColor colorWithRed:249.0/255.0f green:249.0/255.0f blue:249.0/255.0f alpha:1]
//#define KXColorBackGround [CommonTools colorWithHexString:@"#dddddd"]
//#define KXColorBg [CommonTools colorWithHexString:@"#eeeeee"]
//#define KXColorBottomView [CommonTools colorWithHexString:@"#fafafa"]
//#define KXTextColorNew [CommonTools colorWithHexString:@"#222222"]
//#define KXColorCoinYellow [CommonTools colorWithHexString:@"#f6ab00"]
//#define KXColorDegreeYellow [CommonTools colorWithHexString:@"#fce6b2"]
//
//#define KXRemoteColorBlue [UIColor colorWithRed:126.0/255.0f green:191.0/255.0f blue:227.0/255.0f alpha:1]
//#define KXTuWenColorYellow [UIColor colorWithRed:245.0/255.0f green:209.0/255.0f blue:131.0/255.0f alpha:1]
//
//#define KXColorLine [UIColor colorWithRed:230.0/255.0f green:230.0/255.0f blue:230.0/255.0f alpha:1]

//+ (UIColor *)color_blue {
//    return [KXInterFace colorWithRed:0.0 green:135.0 blue:209.0 alpha:1];
//}
//
//+ (UIColor *)color_ligthBlue {
//    return [KXInterFace colorWithRed:202 green:225 blue:237 alpha:1];
//}
//
//+ (UIColor *)color_bg {
//    return [KXInterFace colorWithHexString:@"#eeeeee"];
//}
//
//+ (UIColor *)color_textGray {
//    return [KXInterFace colorWithRed:169 green:169 blue:169 alpha:1];
//}
//
//+ (UIColor *)color_textBlack {
//    return [KXInterFace colorWithRed:45 green:45 blue:45 alpha:1];
//}
//
+ (NSDictionary *)attributedDictionary:(CGFloat)fontSize color:(UIColor *)color {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (fontSize > 0) {
        [dic setValue:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    }
    if (color) {
        [dic setValue:color forKey:NSForegroundColorAttributeName];
    }
    return dic;
}
//
//+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
//    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
//}
//
//+ (UIColor *)colorWithHexString: (NSString *) hexString {
//    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
//    CGFloat alpha = 1, red = 1, blue = 1, green = 1;
//    switch ([colorString length]) {
//        case 3: // #RGB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 1];
//            green = [self colorComponentFrom: colorString start: 1 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
//            break;
//        case 4: // #ARGB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
//            red   = [self colorComponentFrom: colorString start: 1 length: 1];
//            green = [self colorComponentFrom: colorString start: 2 length: 1];
//            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
//            break;
//        case 6: // #RRGGBB
//            alpha = 1.0f;
//            red   = [self colorComponentFrom: colorString start: 0 length: 2];
//            green = [self colorComponentFrom: colorString start: 2 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
//            break;
//        case 8: // #AARRGGBB
//            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
//            red   = [self colorComponentFrom: colorString start: 2 length: 2];
//            green = [self colorComponentFrom: colorString start: 4 length: 2];
//            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
//            break;
//        default:
//            NSLog(@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString);
//            break;
//    }
//    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
//    
//}
//
//
//+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
//    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
//    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
//    unsigned hexComponent;
//    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
//    return hexComponent / 255.0;
//}

@end
