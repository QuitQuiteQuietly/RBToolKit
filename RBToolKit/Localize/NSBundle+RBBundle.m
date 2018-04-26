//
//  NSBundle+RBBundle.m
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import "NSBundle+RBBundle.h"

#import "RBBundle.h"



static NSString *RBLocalLanguageEnumKey = @"RBLocalLanguageEnumKey";
///UserDefault字段  本地化语言
static NSString *RBLocalizeLanguageKey = @"RBLocalizeLanguageKey";

@implementation NSBundle (RBBundle)

+ (eLocalizeLanguage)updateCurrentLanguage:(eLocalizeLanguage)language {
    
    id value = nil;
    
    NSString *systemRead = [self whichSystemRead:language];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:systemRead ofType:@"lproj"];
    
    value = [NSBundle bundleWithPath:path];
    
    [defaults setObject:systemRead forKey:RBLocalizeLanguageKey];
    
    [defaults setObject:@(language) forKey:RBLocalLanguageEnumKey];
    
    
    [defaults synchronize];
    
    ///更新userDefault 并且 将Bundle地址更改
    objc_setAssociatedObject([NSBundle mainBundle], &kRBBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return language;
}

+ (NSString *)whichSystemRead:(eLocalizeLanguage)language {
    switch (language) {
            
        case eLocalizeEnglish:
            return @"en";
            
        case eLocalizeSimpleChinese:
            return @"zh-Hans";
            
    }
}

///替换mainBundle和ZLBundel  方便xib识别本地化文件
+ (void)load {
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        object_setClass([NSBundle mainBundle], [RBBundle class]);
        
        ///确认默认语言
        [NSBundle updateCurrentLanguage:[NSBundle checkLocalizeStatus]];
        
    });
    
}

///查看当前语言
+ (eLocalizeLanguage)checkLocalizeStatus {
    
    NSNumber *status = [[NSUserDefaults standardUserDefaults] valueForKey:RBLocalLanguageEnumKey];
    
    eLocalizeLanguage language = status.integerValue;
    
    
    if (!status) {
        ///默认语言
        language = [self preferredLanguageBySystem];
        [self updateCurrentLanguage:language];
        
    }
    
    return language;
}

///系统当前语言
+ (eLocalizeLanguage)preferredLanguageBySystem {
    
    NSArray *languageArray = [NSLocale preferredLanguages];
    
    for (NSString *lan in languageArray) {
        if ([lan hasPrefix:@"zh-Hans"]) {
            return eLocalizeSimpleChinese;
        }
    }
    
    NSString *z = languageArray.firstObject;
    
    if ([z hasPrefix:@"en"]) {
        return eLocalizeEnglish;
    }
    else if ([z hasPrefix:@"zh-Hans"]) {
        return eLocalizeSimpleChinese;
    }
    else {
        return eLocalizeSimpleChinese;
    }
    
}

@end
