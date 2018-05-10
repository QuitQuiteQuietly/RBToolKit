//
//  RBDir.m
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBDir.h"
@interface RBDir ()



@end

@implementation RBDir

- (instancetype)initDir:(eDir)dir {
    self = [super init];
    if (self) {
        self.dir = dir;
    }
    return self;
}

+ (instancetype)dir {
    NSAssert(NO, @"子类实现");
    return nil;
}


- (NSString *)path {
    NSSearchPathDirectory dir = NSDocumentDirectory;           
    switch (self.dir) {
            
        case eDirDocuments:
            break;
        case eDirLibrary:
            dir = NSLibraryDirectory;
            break;
        case eDirTmp:
            return NSTemporaryDirectory();
    }
    return NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES).lastObject;
}

@end
