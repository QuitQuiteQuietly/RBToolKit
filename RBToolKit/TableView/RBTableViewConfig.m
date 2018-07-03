//
//  RBTableViewConfig.m
//  Kiwi
//
//  Created by Ray on 2018/7/3.
//

#import "RBTableViewConfig.h"

@implementation RBTableViewConfig

@end


@implementation FreshTakes

+ (FreshTakes *)take:(NSInteger)take {
    FreshTakes *t = [FreshTakes new];
    t.taked = 0;
    t.maxTakes = take;
    t.resetAble = YES;
    return t;
}
+ (FreshTakes *)take:(NSInteger)take resetAble:(BOOL)resetAble {
    FreshTakes *t = [FreshTakes take:take];
    t.resetAble = resetAble;
    return t;
}

- (BOOL)continueTake {
    return self.maxTakes > self.taked;
}

- (BOOL)do_take {
    
    self.taked ++;
    
    return self.continueTake;
    
}

- (void)reset {
    
    if (_resetAble) {
        self.taked = 0;
    }
    
}

@end
