//
//  RBLocalize.h
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import <Foundation/Foundation.h>

#import "RBLocalizeEnums.h"

@interface RBLocalize : NSObject

///更新当前语言
+ (eLocalizeLanguage)updateCurrentLanguage:(eLocalizeLanguage)language;

///查看当前语言
+ (eLocalizeLanguage)checkLocalizeStatus;

@end
