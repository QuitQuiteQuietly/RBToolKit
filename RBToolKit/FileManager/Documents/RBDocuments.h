//
//  RBDocuments.h
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBDir.h"


@interface RBUserDir : RBDir

///写用户数据
- (BOOL (^)(NSData *userData))write;

///读取数据
- (id)read;

@end

@interface RBDocuments : RBDir

///用户文件夹
@property (nonatomic, strong)RBUserDir *user;

@end
