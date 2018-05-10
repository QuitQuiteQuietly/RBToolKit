//
//  FileManager.m
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import "RBFileManager.h"

@interface RBFileManager ()

/**  */
@property (nonatomic, strong)RBDocuments *documentsDir;
@property (nonatomic, strong)RBLibrary *libraryDir;
@property (nonatomic, strong)RBTmp *tmpDir;

@end

@implementation RBFileManager





- (RBDocuments *)documentsDir {
    if (!_documentsDir) {
        _documentsDir = (RBDocuments *)[RBDocuments dir];
    }
    return _documentsDir;
}
- (RBLibrary *)libraryDir {
    if (!_libraryDir) {
        _libraryDir = (RBLibrary *)[RBLibrary dir];
    }
    return _libraryDir;
}
- (RBTmp *)tmpDir {
    if (!_tmpDir) {
        _tmpDir = (RBTmp *)[RBTmp dir];
    }
    return _tmpDir;
}

- (RBDocuments *)documents {
    return self.documentsDir;
}
- (RBLibrary *)library {
    return self.libraryDir;
}
- (RBTmp *)tmp {
    return self.tmpDir;
}

@end
