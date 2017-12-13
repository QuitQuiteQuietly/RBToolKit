//
//  NSString+SafeString.h
//  KXInterFace
//
//  Created by Ray on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface NSString (SafeString)

///是否有空字符或nil
//- (NSString *(^)())safe;

///是否有空字符或nil
+ (NSString *(^)(id value))safeString;


/**
 替换字符串
 */
- (NSString *(^)(NSString *occurrences, NSString *replacement))replace;

@end
