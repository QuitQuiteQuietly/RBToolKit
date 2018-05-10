//
//  RBDir.h
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import <Foundation/Foundation.h>

#import "RBDirProtocol.h"

typedef NS_ENUM(NSUInteger, eDir) {
    eDirDocuments = 0,
    eDirLibrary,
    eDirTmp,
};


@interface RBDir : NSObject<RBDirProtocol>

- (instancetype)initDir:(eDir)dir;

/**  */
@property (nonatomic, assign)eDir dir;

+ (instancetype)dir;

@end
