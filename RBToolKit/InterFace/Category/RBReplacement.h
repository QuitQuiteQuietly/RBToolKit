//
//  RBReplacement.h
//  Kiwi
//
//  Created by Ray on 2018/5/3.
//

#import <Foundation/Foundation.h>

@interface RBReplacement : NSObject


/**
 交换方法

 @param class 类
 @param origin 原方法
 @param swizzled 需要替换成的方法
 */
+ (void)switchMethod:(Class)class origin:(SEL)origin swizzled:(SEL)swizzled;

@end
