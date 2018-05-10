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

//- (NSString *)userData {
//    
//    NSString *path = self.path;
//    
//    return [path stringByAppendingPathComponent:[self user]];
//    
//}

+ (instancetype)dir {
    RBDocuments *d = [[RBDocuments alloc]initDir:eDirDocuments];
    return d;
}

//
/////是否存在 --/Documents/User
//- (BOOL)checkDocumentUserDir {
//
//    NSString *userDir = [self documents_userWithUserData:NO];
//
//    NSFileManager *file = [NSFileManager defaultManager];
//
//    BOOL exists = [file fileExistsAtPath:userDir];
//    if (!exists) {
//        exists = [file createDirectoryAtPath:userDir withIntermediateDirectories:NO attributes:nil error:nil];
//    }
//
//    return exists;
//}
//
/////文件夹
//- (NSString *)documents_userWithUserData:(BOOL)with {
//    /// --/Documents
//    NSString *docmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    /// --/Documents/User
//    NSString *userDir = [docmentPath stringByAppendingPathComponent:@"User"];
//    return with ? [userDir stringByAppendingPathComponent:[self userData]] : userDir;
//}
//

//#endif

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

- (BOOL)writeUserData:(NSData *)userData {
    
    NSFileManager *file = [NSFileManager defaultManager];
    
    ///文件夹路径
    NSString *final = self.path;
    
    ///开始校验文件夹是否存在
    BOOL exists = [self checkUserData:file path:[final copy]];
    
    NSError *error = nil;
    
    ///操作文件
    final = [final stringByAppendingPathComponent:[self user]];
    exists = [file fileExistsAtPath:final];
    
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
    return @"userData_Debug";
}
#else
- (NSString *)user {
    return @"userData";
}
#endif
@end
