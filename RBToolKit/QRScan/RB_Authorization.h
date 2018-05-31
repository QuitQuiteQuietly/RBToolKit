//
//  RB_Authorization.h
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, eAuthorizeOption) {
    eAuthorizeOptionAlbum = 1 << 0,
    eAuthorizeOptionCamera = 1 << 1
};

typedef void(^pass)(eAuthorizeOption op, BOOL pass);

@interface RB_Authorization : NSObject


+ (void)authorize:(pass)process option:(eAuthorizeOption)option;


@end
