//
//  NSNumber+time.h
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (Time)


/**
 将服务器返回的毫秒转成秒

 @return milliseconds --> seconds
 */
- (NSNumber *)secondsValue;

/**
 今天/明天  14:34
 
 @return 今天/明天  14:34
 */
- (NSString *)transToPastTime;



/**
 根据日期格式返回
 
 format : @"yyyy-MM-dd-HH-mm-ss"
 */
- (NSString *(^)(NSString *format))transToPastTimeWithFormat;


@end
