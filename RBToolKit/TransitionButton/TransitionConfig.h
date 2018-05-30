//
//  TransitionConfig.h
//  Kiwi
//
//  Created by Ray on 2018/5/29.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, eTransitionDone) {
    eTransitionDoneNormal,
    eTransitionDoneExpand
};

@class TransitionStyle;

@interface TransitionConfig : NSObject


+ (TransitionConfig *)config;


/**  */
@property (nonatomic, assign)eTransitionDone afterDone;

/**  */
@property (nonatomic, strong)TransitionStyle *style;

@end


#pragma mark - - - - - - -

typedef NS_ENUM(NSUInteger, eTransitionType) {
    eTransitionTypeNormal,
    eTransitionTypeShrik
};

typedef NS_ENUM(NSUInteger, eIndicatorPosition) {
    eIndicatorPositionLeading,
    eIndicatorPositionCenter,
    eIndicatorPositionTrailing,
};

@interface TransitionStyle : NSObject

+ (TransitionStyle *)defalutStyle;

/** 类型 */
@property (nonatomic, assign)eTransitionType style;

/** 位置 */
@property (nonatomic, assign)eIndicatorPosition position;

@end
