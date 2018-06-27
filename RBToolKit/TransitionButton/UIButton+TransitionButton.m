//
//  TransitionButton.m
//  Kiwi
//
//  Created by Ray on 2018/5/25.
//

#import "UIButton+TransitionButton.h"

#import "Indicator.h"

#import <ObjC/runtime.h>

//@interface TransitionButton ()
//
///**  */
//@property (nonatomic, strong)Indicator *indicator;
//
///**  */
//@property (nonatomic, strong)UIImage *cacheImage;
//
///**  */
//@property (nonatomic, strong)NSString *cacheTitle;
//
//@end

static void *cache_Image = @"cacheImage";
static void *cache_Title = @"cacheTitle";
static void *cache_Corner = @"cache_Corner";
static void *config_key = @"config_tran";
static void *indicating_key = @"indicating";
static void *delay_key = @"delay_key";

@interface UIButton (CacheOrigin)

/**  */
@property (nonatomic, strong)UIImage *cacheImage;

/**  */
@property (nonatomic, strong)NSString *cacheTitle;

/**  */
@property (nonatomic, assign)CGFloat cacheCorner;

/**  */
@property (nonatomic, strong)TransitionConfig *config;

/**  */
@property (nonatomic, assign)BOOL indicating;

@property (nonatomic, assign)NSInteger delay;

@end

@implementation UIButton (CacheOrigin)
- (void)setIndicating:(BOOL)indicating {
    objc_setAssociatedObject(self, &indicating_key, @(indicating), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setCacheCorner:(CGFloat)cacheCorner {
    objc_setAssociatedObject(self, &cache_Corner, @(cacheCorner), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setCacheImage:(UIImage *)cacheImage {
    objc_setAssociatedObject(self, &cache_Image, cacheImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setCacheTitle:(NSString *)cacheTitle {
    objc_setAssociatedObject(self, &cache_Title, cacheTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setConfig:(TransitionConfig *)config {
    objc_setAssociatedObject(self, &config_key, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setDelay:(NSInteger)delay {
    objc_setAssociatedObject(self, &delay_key, @(delay), OBJC_ASSOCIATION_ASSIGN);
}
- (TransitionConfig *)config {
   return objc_getAssociatedObject(self, &config_key);
}
- (BOOL)indicating {
    return [objc_getAssociatedObject(self, &indicating_key) boolValue];
}
- (UIImage *)cacheImage {
    return objc_getAssociatedObject(self, &cache_Image);
}
- (NSString *)cacheTitle {
    return objc_getAssociatedObject(self, &cache_Title);
}
- (CGFloat)cacheCorner {
    return [objc_getAssociatedObject(self, &cache_Corner) floatValue];
}
- (NSInteger)delay {
    return [objc_getAssociatedObject(self, &delay_key) integerValue];
}

@end

static void *indicator = @"indicator";

static void *start_key = @"start_key";

@implementation UIButton (TransitionButton)

- (void)animate:(BOOL)start {
    self.start = start;
}

- (void)animate:(BOOL)start stop_delay:(NSInteger)delay {
    [self animate:start];
    self.delay = delay;
}

- (void)setStart:(BOOL)start {
    objc_setAssociatedObject(self, &start_key, @(start), OBJC_ASSOCIATION_ASSIGN);
    if (start) {
        [self start:nil];
    }
    else {
        [self stop];
    }
}
- (BOOL)start {
   return [objc_getAssociatedObject(self, &start_key) boolValue];
}

- (void)start:(void (^)(TransitionConfig *))config {
    
    TransitionConfig *c = [TransitionConfig config];
    
    if (config) {
        config(c);
    }
    
    self.config = c;
    
    self.userInteractionEnabled = NO;
    
    [self storgeOriginState:YES];
    
    switch (self.config.style.style) {

        case eTransitionTypeNormal:
            break;
        case eTransitionTypeShrik:
            [self shrink:YES];
            break;
            
    }
    
    self.indicating = YES;
    
    [self indicatorStart:YES];
    
}



- (void)storgeOriginState:(BOOL)storge {
    
    if (storge) {
        self.cacheImage = [self imageForState:UIControlStateNormal];
        self.cacheTitle = [self titleForState:UIControlStateNormal];
        self.cacheCorner = self.layer.cornerRadius;

        [self setTitle:@"" forState:UIControlStateNormal];
        if (self.cacheImage) {
            [self setImage:nil forState:UIControlStateNormal];
        }
        
    }
    else {
        [self setTitle:self.cacheTitle forState:UIControlStateNormal];
        [self setImage:self.cacheImage forState:UIControlStateNormal];
        self.layer.cornerRadius = self.cacheCorner;
    }
    
}

- (void)stop {
    
    if (!self.indicating) {
        return;
    }
    
    if (self.delay) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self do_stop];
        });
    }
    else {
        [self do_stop];
    }
    
    
}

- (void)do_stop {
    self.indicating = NO;
    
    self.userInteractionEnabled = YES;
    
    [self indicatorStart:NO];
    
    switch (self.config.style.style) {
            
        case eTransitionTypeNormal:
            break;
        case eTransitionTypeShrik:
            [self shrink:NO];
            break;
    }
    
    switch (self.config.afterDone) {
            
        case eTransitionDoneNormal:
            break;
        case eTransitionDoneExpand:
            [self expand];
            return;
    }
    
    [self storgeOriginState:NO];
}

/**
 缩放

 @param small 缩小/还原
 */
- (void)shrink:(BOOL)small {

    CGFloat from = small ? self.frame.size.width : self.bounds.size.height;
    CGFloat to = small ? self.frame.size.height : self.bounds.size.width;

    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue             = @(from);
    shrinkAnim.toValue               = @(to);
    shrinkAnim.duration              = 0.1;

    CAMediaTimingFunction *shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    shrinkAnim.timingFunction        = shrinkCurve;
    shrinkAnim.fillMode              = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = NO;

    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];

    if (small) {
        self.layer.cornerRadius = self.frame.size.height / 2;
    }
    
}

- (void)indicatorStart:(BOOL)start {
    if (start) {
        [self.indicator animation];
    }
    else {
        [self.indicator stop];
    }
}


- (void)expand {
    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnim.fromValue            = @1;
    expandAnim.toValue              = @(26);

    CAMediaTimingFunction *expandCurve = [CAMediaTimingFunction functionWithControlPoints:.95 :.02 :1 :.05];
    expandAnim.timingFunction = expandCurve;
    expandAnim.duration = 0.3;
    expandAnim.fillMode = kCAFillModeForwards;
    expandAnim.removedOnCompletion  = YES;

    [CATransaction setCompletionBlock:^{
        [self.indicator stop];
    }];

    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];

    [CATransaction commit];
}

- (Indicator *)indicator {
    
    Indicator *ind = objc_getAssociatedObject(self, &indicator);
    
    if (!ind) {
        
        ind = [[Indicator alloc]initWithFrame:self.frame color:[self titleColorForState:UIControlStateNormal]];
        
        objc_setAssociatedObject(self, &indicator, ind, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    if (eTransitionTypeShrik != self.config.style.style) {
        switch (self.config.style.position) {
                
            case eIndicatorPositionLeading:
                break;
            case eIndicatorPositionCenter:
                ind.frame = CGRectMake((CGRectGetWidth(self.frame) - ind.frame.size.width) / 2, 0, ind.frame.size.width, ind.frame.size.height);
                break;
            case eIndicatorPositionTrailing:
                ind.frame = CGRectMake(CGRectGetWidth(self.frame) - ind.frame.size.width, 0, ind.frame.size.width, ind.frame.size.height);
                break;
        }
    }
    

    [self.layer addSublayer:ind];
    
    return ind;
}



@end
