//
//  RBReplacement.m
//  Kiwi
//
//  Created by Ray on 2018/5/3.
//

#import "RBReplacement.h"

#import <ObjC/runtime.h>

@implementation RBReplacement

+ (void)switchMethod:(Class)class origin:(SEL)origin swizzled:(SEL)swizzled {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        Method originalMethod = class_getInstanceMethod(class, origin);
        Method swizzledMethod = class_getInstanceMethod(class, swizzled);
        
        BOOL didAddMethod = class_addMethod(class,
                                            origin,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if(didAddMethod){
            class_replaceMethod(class,
                                swizzled,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod,swizzledMethod);
        }
    });
}


@end
