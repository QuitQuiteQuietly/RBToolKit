//
//  RBFileManager.h
//  Kiwi
//
//  Created by Ray on 2018/5/10.
//

#import <Foundation/Foundation.h>

#import "RBDocuments.h"
#import "RBLibrary.h"
#import "RBTmp.h"

@interface RBFileManager : NSObject

/**  */
@property (nonatomic, readonly)RBDocuments *documents;

@property (nonatomic, readonly)RBLibrary *library;

@property (nonatomic, readonly)RBTmp *tmp;

@end
