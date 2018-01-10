//
//  KXTime.h
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import <Foundation/Foundation.h>

@interface RBTime : NSObject


/**
 今天/明天  14:34
 
 传入毫秒
 
 @return 今天/明天  14:34
 */
+ (NSString *(^)(double milliSecond))time;

/**
 今天/明天  14:34
 
 传入秒
 
 @return 今天/明天  14:34
 */
+ (NSString *(^)(double second))time_second;



#pragma mark -
/**
 今天/明天  14:34

 @param time seconds
 @return 今天/明天  14:34
 */
+ (NSString *)getDateConvertToLocalTime:(double)time;



/**
 根据日期格式返回
 
 format : @"yyyy-MM-dd-HH-mm-ss"
 */
+ (NSString *)getDateWithFormat:(NSString *)format withPastSeconds:(double)time;

@end
