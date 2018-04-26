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
    
//    f.maxSeconds = countdown;
    
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

}


@end
