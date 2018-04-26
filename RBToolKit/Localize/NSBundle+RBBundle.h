//
//  NSBundle+RBBundle.h
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import <Foundation/Foundation.h>

#import "RBLocalizeEnums.h"

@interface NSBundle (RBBundle)

+ (eLocalizeLanguage)updateCurrentLanguage:(eLocalizeLanguage)language;

///查看当前语言
+ (eLocalizeLanguage)checkLocalizeStatus;

@end
