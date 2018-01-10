//
//  NSNumber+time.m
//  Pods
//
//  Created by Ray on 2017/9/27.
//
//

#import "NSNumber+Time.h"

#import "RBTime.h"

@implementation NSNumber (Time)

- (NSString *)transToPastTime {

    return [RBTime getDateConvertToLocalTime:self.doubleValue];

}


- (NSString *(^)(NSString *))transToPastTimeWithFormat {
    return ^(NSString *format) {
        return [RBTime getDateWithFormat:format withPastSeconds:self.doubleValue];
    };
}

- (NSNumber *)secondsValue {

    return @([self millisecondTransToSecond]);
}

- (double)millisecondTransToSecond {
    
    if (self.doubleValue < 0.0f) {
        return 0.0;
    }
    return self.doubleValue / 1000;
}

@end
