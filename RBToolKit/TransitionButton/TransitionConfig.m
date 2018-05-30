//
//  TransitionConfig.m
//  Kiwi
//
//  Created by Ray on 2018/5/29.
//

#import "TransitionConfig.h"

@implementation TransitionConfig

+ (TransitionConfig *)config {
    
    TransitionConfig *c = [TransitionConfig new];
    
    c.style = [TransitionStyle defalutStyle];
    c.afterDone = eTransitionDoneNormal;
    
    return c;
    
}

@end


@implementation TransitionStyle


+ (TransitionStyle *)defalutStyle {
    TransitionStyle *s = [TransitionStyle new];
    s.position = eIndicatorPositionCenter;
    s.style = eTransitionTypeNormal;
    return s;
}

@end
