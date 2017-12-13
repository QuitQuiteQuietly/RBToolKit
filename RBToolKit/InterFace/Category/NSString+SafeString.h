//
//  NSString+SafeString.h
//  KXInterFace
//
//  Created by Ray on 2017/10/12.
//

#import <Foundation/Foundation.h>

@interface NSString (SafeString)


///是否有空字符或nil
+ (NSString *(^)(id value))safe;

/**
 替换字符串
 */
- (NSString *(^)(NSString *occurrences, NSString *replacement))replace;

@end
