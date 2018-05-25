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

@interface UIButton (CacheOrigin)

/**  */
@property (nonatomic, strong)UIImage *cacheImage;

/**  */
@property (nonatomic, strong)NSString *cacheTitle;

/**  */
@property (nonatomic, assign)CGFloat cacheCorner;

@end

@implementation UIButton (CacheOrigin)
- (void)setCacheCorner:(CGFloat)cacheCorner {
    objc_setAssociatedObject(self, &cache_Corner, @(cacheCorner), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setCacheImage:(UIImage *)cacheImage {
    objc_setAssociatedObject(self, &cache_Image, cacheImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setCacheTitle:(NSString *)cacheTitle {
    objc_setAssociatedObject(self, &cache_Title, cacheTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

@end

static void *indicator = @"indicator";

@implementation UIButton (TransitionButton)

- (void)start {
    
    self.userInteractionEnabled = NO;
    
    self.layer.cornerRadius = 4;
    
    [self storgeOriginState:YES];
    
    [self shrink:YES];
    
}


- (void)storgeOriginState:(BOOL)storge {
    
    if (storge) {
        self.cacheImage = [self imageForState:UIControlStateNormal];
        self.cacheTitle = [self titleForState:UIControlStateNormal];
        self.cacheCorner = self.layer.cornerRadius;
        
        [self setTitle:@"" forState:UIControlStateNormal];
        
    }
    else {
        [self setTitle:self.cacheTitle forState:UIControlStateNormal];
        [self setImage:self.cacheImage forState:UIControlStateNormal];
        self.layer.cornerRadius = self.cacheCorner;
    }
    
}

- (void)stop {
    
    [self backOriginState];
}

- (void)backOriginState {
    
    [self shrink:NO];
    
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
    
    self.userInteractionEnabled = !small;
    
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    
    [self storgeOriginState:NO];
    
    if (small) {
        self.layer.cornerRadius = self.frame.size.height / 2;

        [self.indicator animation];
    }
    else {
        [self.indicator stop];
    }
    
}


//- (void)expand {
//    CABasicAnimation *expandAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    expandAnim.fromValue            = @1;
//    expandAnim.toValue              = @(26);
//
//    CAMediaTimingFunction *expandCurve = [CAMediaTimingFunction functionWithControlPoints:.95 :.02 :1 :.05];
//    expandAnim.timingFunction = expandCurve;
//    expandAnim.duration = 0.4;
//    expandAnim.fillMode = kCAFillModeForwards;
//    expandAnim.removedOnCompletion  = NO;
//
//    [CATransaction setCompletionBlock:^{
//
//
//        [self.indicator stop];
//
//    }];
//
//    [self.layer addAnimation:expandAnim forKey:expandAnim.keyPath];
//
//    [CATransaction commit];
//}

- (Indicator *)indicator {
    
    Indicator *ind = objc_getAssociatedObject(self, &indicator);
    
    if (!ind) {
        
        ind = [[Indicator alloc]initWithFrame:self.frame];
        
        objc_setAssociatedObject(self, &indicator, ind, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    
    [self.layer addSublayer:ind];
    
    return ind;
}


@end
