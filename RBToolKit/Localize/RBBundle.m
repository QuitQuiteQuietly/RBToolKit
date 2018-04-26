//
//  RBBundle.m
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import "RBBundle.h"

@implementation RBBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    
    NSBundle *bundle = objc_getAssociatedObject(self, &kRBBundleKey);
    
    if (bundle) {
        
        return [bundle localizedStringForKey:key value:value table:tableName];
        
    }
    else {
        
        return [super localizedStringForKey:key value:value table:tableName];
        
    }
}


@end
