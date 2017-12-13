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

+ (NSString *(^)(id))safe {
    return ^(id value) {
        
        if (!value || ![value isKindOfClass:[NSString class]]) {
            
            if ([value isKindOfClass:NSNumber.class]) {
                return [self outputSafeString:[(NSNumber *)value stringValue]];
            }
            
            return @"";
        }
        return [self outputSafeString:(NSString *)value];
    };
}

+ (NSString *)outputSafeString:(NSString *)value {
    if (value == NULL) {
        return @"";
    }
    return value.length ? value : @"";
}

@end
