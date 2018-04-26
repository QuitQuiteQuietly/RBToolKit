//
//  RBLocalize.m
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import "RBLocalize.h"

#import "NSBundle+RBBundle.h"

@implementation RBLocalize

+ (eLocalizeLanguage)updateCurrentLanguage:(eLocalizeLanguage)language {
    return [NSBundle updateCurrentLanguage:language];
}

+ (eLocalizeLanguage)checkLocalizeStatus {
    return [NSBundle checkLocalizeStatus];
}

@end
