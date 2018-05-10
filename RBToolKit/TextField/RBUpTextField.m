//
//  RBUpTextField.m
//  Kiwi
//
//  Created by Ray on 2018/5/8.
//

#import "RBUpTextField.h"

#import "ReactiveObjC.h"

@interface RBUpTextField()
{
    //    UILabel *self.self.placeholder;
    CGFloat inset;
    
    CGPoint textFieldInset,placeholderInset;
}

@property (nonatomic, strong)UILabel *placeHolderLabel;

/** 是否需要动画过度 */
@property (nonatomic, assign)BOOL animateUp;

/** 线 */
@property (nonatomic, strong)CAShapeLayer *lineLayer;

/** label高度 */
@property (nonatomic, assign)CGFloat labelY;

@end

@implementation RBUpTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [self selfListen];

}
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        [self selfListen];
    }
    return self;
}

- (void)animateDoUp:(BOOL)isUp {
    if (!self.animateUp) return;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.placeHolderLabel.frame=CGRectMake(0, isUp ? self.labelY : 0, self.bounds.size.width, self.bounds.size.height);
    } completion:nil];
}

- (void)selfListen {
    @weakify(self)
    [[self.rac_textSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        [self animateDoUp:YES];
    }];
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"UIControlEventEditingDidEnd");
        @strongify(self)
        [self animateDoUp:NO];
    }];
    
    [[self rac_signalForControlEvents:UIControlEventEditingDidEndOnExit] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"UIControlEventEditingDidEndOnExit");
    }];
}
- (void)drawSomething {
    
    [self.layer addSublayer:self.lineLayer];
    [self addSubview:self.placeHolderLabel];

    @weakify(self)
    [[RACObserve(self, animateUp) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *_Nullable x) {
        @strongify(self)
        self.labelY = x.boolValue ? 0 : -24.f;
    }];
    
    self.placeHolderLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
    
}

- (CAShapeLayer *)lineLayer {
    
    if (!_lineLayer) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat pointY = self.bounds.size.height + 2;
        
        [path moveToPoint:CGPointMake(0, pointY)];
        
        [path addLineToPoint:CGPointMake(self.bounds.size.width, pointY)];
        
        _lineLayer = [CAShapeLayer layer];
        
        _lineLayer.path = path.CGPath;
        _lineLayer.strokeColor = [[UIColor whiteColor] CGColor];
        _lineLayer.borderWidth = 1.0f;
    }
    return _lineLayer;
}

//- (CGRect)borderRectForBounds:(CGRect)bounds {
//    return CGRectMake(0, 0, self.frame.size.width, 40);
//}

//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectMake(0, 0, bounds.size.width, 30);
//}
//
//-(CGRect)editingRectForBounds:(CGRect)bounds{
//    return [self textRectForBounds:bounds];
//}
//
-(CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect r = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//    NSLog(@"%@", [NSValue valueWithCGRect:r]);
    return r;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    NSLog(@"%@", [NSValue valueWithCGRect:bounds]);
    return CGRectMake(0, self.bounds.size.height / 2, self.bounds.size.width, self.bounds.size.height / 2);
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.text = @"Add comment here";
        _placeHolderLabel.textColor = [UIColor whiteColor];
        _placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _placeHolderLabel;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [self drawSomething];
    
}


@end
