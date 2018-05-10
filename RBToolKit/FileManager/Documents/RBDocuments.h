//
//  RBDocuments.h
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBDir.h"


@interface RBUserDir : RBDir

//- (BOOL)checkUserData;

//- (BOOL)writeUserData:(NSData *)userData;
///写用户数据
- (BOOL (^)(NSData *userData))write;

@end

@interface RBDocuments : RBDir

///用户文件夹
@property (nonatomic, strong)RBUserDir *user;

@end
