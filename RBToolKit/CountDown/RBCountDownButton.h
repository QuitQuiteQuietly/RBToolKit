//
//  RBCountDownButton.h
//  Kiwi
//
//  Created by Ray on 2018/4/26.
//

#import <UIKit/UIKit.h>

@interface RBCountDownButton : UIButton

/** 需要多少秒  默认 60 */
@property (nonatomic, assign)IBInspectable NSInteger countDown;

/**
 默认
 
 @param countdown 需要多少秒  默认 60
 @return 默认
 */
+ (RBCountDownButton *)defaultCountDownBtn:(NSInteger)countdown;


@end
