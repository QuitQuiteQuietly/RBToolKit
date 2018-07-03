//
//  RBTableViewConfig.h
//  Kiwi
//
//  Created by Ray on 2018/7/3.
//

#import <Foundation/Foundation.h>

@interface RBTableViewConfig : NSObject

@end




#pragma mark - takes


@interface FreshTakes : NSObject

+ (FreshTakes *)take:(NSInteger)take;

/**
 计数器

 @param take 计数次数
 @param resetAble 是否可以被重置 (+ (FreshTakes *)take:(NSInteger)take;)默认reset为 YES
 @return 计数器
 */
+ (FreshTakes *)take:(NSInteger)take resetAble:(BOOL)resetAble;

/** 最大take */
@property (nonatomic, assign)NSInteger maxTakes;

/** 目前take */
@property (nonatomic, assign)NSInteger taked;

/** 是否可以被重置 */
@property (nonatomic, assign)BOOL resetAble;

/** 是否继续 */
@property (nonatomic, assign, readonly)BOOL continueTake;


/**
 开始执行

 @return 是否继续
 */
- (BOOL)do_take;

///重置计数器
- (BOOL)reset;

@end





@interface RB_Refresh <__covariant Refresh> : NSObject

typedef void(^delay)(Refresh refresh);
typedef void(^disable)(BOOL disable, Refresh refresh);

+ (RB_Refresh *)refresh:(Refresh)refresh delay:(delay)delay disable:(disable)disable;
/**  */
@property (nonatomic, assign)BOOL enable;

/**  */
@property (nonatomic, strong)Refresh refresh;

- (void)trigger;

@end



