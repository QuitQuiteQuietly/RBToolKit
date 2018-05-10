//
//  RBDocuments.m
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBDocuments.h"

@implementation RBDocuments

- (RBUserDir *)user {
    if (!_user) {
        _user = [RBUserDir dir];
    }
    return _user;
}

+ (instancetype)dir {
    RBDocuments *d = [[RBDocuments alloc]initDir:eDirDocuments];
    return d;
}


@end

@implementation RBUserDir
+ (instancetype)dir {
    return [[RBUserDir alloc]initDir:eDirDocuments];
}
- (NSString *)path {
    return [super.path stringByAppendingPathComponent:@"User"];
}

- (BOOL (^)(NSData *))write {
    typeof(self) weakSelf = self;
    return ^BOOL (NSData *data) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        return [strongSelf writeUserData:data];
    };
}

- (id)read {

    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathOfUserData]];
    
}

- (BOOL)remove {
    BOOL existsNoMore = YES;
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:[self pathOfUserData]]) {
        existsNoMore = [file removeItemAtPath:[self pathOfUserData] error:nil];
    }
    return existsNoMore;
}

- (BOOL)writeUserData:(NSData *)userData {
    
    NSFileManager *file = [NSFileManager defaultManager];
    
    ///文件夹路径
    NSString *final = self.path;
    
    ///开始校验文件夹是否存在
    BOOL exists = [self checkUserData:file path:[final copy]];
    
    NSError *error = nil;
    
   ///寻找文件
    final = [self pathOfUserData];
    exists = [file fileExistsAtPath:final];
    
    ///操作文件
    if (exists) {
        ///文件 已存在 覆盖
        exists = [userData writeToFile:final options:NSDataWritingAtomic error:&error];
    }
    else {
        ///不存在。创建
        exists = [file createFileAtPath:final contents:userData attributes:nil];
    }
    NSLog(@"%@", error);
    return exists;
}

- (NSString *)pathOfUserData {
    return [self.path stringByAppendingPathComponent:[self user]];
}

///校验文件夹是否存在 --/Documents/User
- (BOOL)checkUserData:(NSFileManager *)file path:(NSString *)path {
    
    BOOL exists = [file fileExistsAtPath:self.path];
    if (!exists) {
        ///如果文件夹不存在 则创建
        exists = [file createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    return exists;
}
#ifdef DEBUG
- (NSString *)user {
    return @"UserData_Debug";
}
#else
- (NSString *)user {
    return @"UserData";
}
#endif
@end
