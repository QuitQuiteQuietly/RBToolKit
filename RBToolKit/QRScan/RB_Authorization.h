//
//  RB_Authorization.h
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, eAuthorizeOption) {
    ///相机
    eAuthorizeOptionCamera = 1 << 0,
    ///相册 读
    eAuthorizeOptionAlbum_read = 1 << 1,
    ///相机 写
    eAuthorizeOptionAlbum_read_write = 1 << 2,
};

typedef void(^pass)(eAuthorizeOption op, BOOL pass);

@interface RB_Authorization : NSObject


+ (void)authorize:(pass)process option:(eAuthorizeOption)option;


@end



@interface RB_Authorization (Flash)


/**
 是否开启手电筒

 @param on 是否开启
 */
+ (void)flash:(BOOL)on;

+ (void)flash:(BOOL)on error:(NSError **)error;

@end
