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

- (BOOL)reset {
    
    if (_resetAble) {
        self.taked = 0;
    }
    
    return self.continueTake;
}

@end


@interface RB_Refresh ()

/**  */
@property (nonatomic, copy)delay delay;

@property (nonatomic, copy)disable disable;

@end


@implementation RB_Refresh

+ (RB_Refresh *)refresh:(id)refresh delay:(delay)delay disable:(disable)disable {
    RB_Refresh *r = [RB_Refresh new];
    r.refresh = refresh;
    r.delay = delay;
    r.disable = disable;
    return r;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    if (self.disable) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.disable(!self.enable, self.refresh);
        });
    }
}

- (void)trigger {
    if (self.enable && self.delay) {
        self.delay(self.refresh);
    }
}

//@dynamic refresh;

@end
