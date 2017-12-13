//
//  KXInterFace.m
//  KXDoctor
//
//  Created by Ray on 2017/9/23.
//  Copyright © 2017年 Peak. All rights reserved.
//

#import "RBInterFace.h"

@implementation RBInterFace

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

@end
