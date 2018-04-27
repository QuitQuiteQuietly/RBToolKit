//
//  RBCountDownButton.m
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import "RBCountDownButton.h"

#import "ReactiveObjC.h"

@interface RBCountDownButton ()
/**  */
@property (nonatomic, strong)RACSignal *timer;

/**  */
@property (nonatomic, assign)NSInteger remainSeconds;

@property (nonatomic, assign)NSInteger maxSeconds;

/**  */
//@property (nonatomic, assign)eLocalizeLanguage currentLanguage;
@property (nonatomic, strong)NSString *reSend;

/**  */
@property (nonatomic, strong)RACMulticastConnection *publish;

@end

@implementation RBCountDownButton

+ (RBCountDownButton *)defaultCountDownBtn:(NSInteger)countdown {
    
    RBCountDownButton *f = [RBCountDownButton buttonWithType:UIButtonTypeCustom];
    
    f.maxSeconds = countdown;
    
    return f;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    [self setDefaultValue];
    
    RAC(self, enabled) = [RACSignal combineLatest:@[RACObserve(self, remainSeconds)] reduce:^NSNumber *(NSNumber *remains){
        return @(remains.integerValue == 0);
    }];
    
    self.publish = [[self rac_signalForControlEvents:UIControlEventTouchUpInside] publish];
    [self.publish connect];
    
    @weakify(self)

    self.timer = [[[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] map:^NSString *_Nullable(NSDate * _Nullable value) {
        @strongify(self)
        self.remainSeconds --;
        return [self titleDisplayCurrently];
    }] take:self.maxSeconds] takeUntil:self.rac_willDeallocSignal];
    
    ///点击事件
    [[self.publish.signal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
        [self sendSms];
        
        self.remainSeconds = self.maxSeconds;
        
        [self shouldChangeTitle];
        
    }];
}

- (NSString *)titleDisplayCurrently {
    return [NSString stringWithFormat:@"%ld后重新发送", self.remainSeconds];
}

- (void)sendSms { }

- (void)shouldChangeTitle {
    
    @weakify(self)
    [self.timer subscribeNext:^(NSString *_Nullable x) {
        @strongify(self)
        [self setTitle:x forState:UIControlStateNormal];
    } completed:^{
        @strongify(self)
        [self setTitle:@"重新发送" forState:UIControlStateNormal];
    }];

}

- (void)setDefaultValue {
    if (!self.maxSeconds) {
        self.maxSeconds = 60;
    }
    
    [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

@end
