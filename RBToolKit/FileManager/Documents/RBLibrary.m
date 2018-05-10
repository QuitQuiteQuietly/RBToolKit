//
//  RBLibrary.m
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBLibrary.h"

@implementation RBLibrary

+ (instancetype)dir {
    RBLibrary *d = [[RBLibrary alloc]initDir:eDirLibrary];
    return d;
}

@end
