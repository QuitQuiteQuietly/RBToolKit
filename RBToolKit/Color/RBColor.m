//
//  KXColor.m
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import "RBColor.h"

@implementation RBColor
+ (UIColor *)color_blue {
    return [RBColor colorWithRed:0.0 green:135.0 blue:209.0 alpha:1];
}

+ (UIColor *)color_ligthBlue {
    return [RBColor colorWithRed:202 green:225 blue:237 alpha:1];
}

+ (UIColor *)color_bg {
    return [RBColor colorWithHexString:@"#eeeeee"];
}

+ (UIColor *)color_textGray {
    return [RBColor colorWithRed:169 green:169 blue:169 alpha:1];
}

+ (UIColor *)color_textBlack {
    return [RBColor colorWithRed:45 green:45 blue:45 alpha:1];
}

+ (UIColor *)color_textYellow {
    return [RBColor colorWithRed:246 green:171 blue:0 alpha:1];
}

+ (UIColor *)color_coinYellow {
    return [RBColor colorWithHexString:@"#f6ab00"];
}

+ (UIColor *)color_colorWhite {
    return [UIColor whiteColor];
}

+ (UIColor *)color_colorBlack {
    return [UIColor blackColor];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}


+ (UIColor *)colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    CGFloat alpha = 1, red = 1, blue = 1, green = 1;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            NSLog(@"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString);
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}


+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
