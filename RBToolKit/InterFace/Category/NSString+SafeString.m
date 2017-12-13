//
//  NSString+SafeString.m
//  KXInterFace
//
//  Created by Ray on 2017/10/12.
//

#import "NSString+SafeString.h"

@implementation NSString (SafeString)

- (NSString *(^)(NSString *, NSString *))replace {
    return ^(NSString *occurrences, NSString *replacement) {
        return [self stringByReplacingOccurrencesOfString:occurrences withString:replacement];
    };
}

//- (NSString *(^)())safe {
//    return ^() {
//        
//        if (!self) {
//            return @"";
//        }
//        
//        if (self.length) {
//            if ([self isEqualToString:@"null"] || [self isEqualToString:@"<null>"]) {
//                return @"";
//            }
//            return self;
//        }
//        return @"";
//    };
//}

+ (NSString *(^)(id))safeString {
    return ^(id value) {
        
        if (!value || ![value isKindOfClass:[NSString class]]) {
            return @"";
        }
        
        NSString *x = value;
        
        if (x.length) {
            if ([x isEqualToString:@"null"] || [x isEqualToString:@"<null>"]) {
                return @"";
            }
            return x;
        }
        return @"";
    };
}

@end
