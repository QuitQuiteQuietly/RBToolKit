//
//  RBTableView.h
//  Kiwi
//
//  Created by Ray on 2018/5/2.
//

#import <UIKit/UIKit.h>

@class RBTableView;

typedef void(^refresh)(BOOL header, NSInteger page, RBTableView *tableView);

typedef NS_ENUM(NSUInteger, eTableViewBg) {
    eTableViewBgNoData,
    eTableViewBgNetGoesWrong
};

@interface RBTableView : UITableView


- (instancetype)initWithStyle:(UITableViewStyle)style refresh:(refresh)refresh;

///内部拥有set方法，防止复写
@property (nonatomic, readonly, copy)refresh refresh;


/**
 当 拉动 tableview 时
 
 @param refresh ""
 */
- (void)rb_mj_refresh:(refresh)refresh enableHeader:(BOOL)header footer:(BOOL)footer;


/**
 结束刷新状态
 
 @param success 请求是否成功（影响自身的PageIndex）
 @param noMoreData 是否无更多数据
 */
- (void)endRefreshAndRequestSuccess:(BOOL)success
                     withNoMoreData:(BOOL)noMoreData
                            isEmpty:(BOOL)isEmpty;


/**
 结束刷新

 @param displayNoMoreData 是否显示已无更多数据
 */
- (void)endRefresh:(BOOL)displayNoMoreData;


/** 首次请求--会将isHeader和pageIndex都置为0
 *  startRefresh -- pullAnimate 默认 YES
 */
- (void)startRefresh;
- (void)startRefresh:(BOOL)pullAnimate;

///当前的页数
@property (nonatomic, readonly, assign)NSInteger currentPageIndex;



/**
 生成图片
 
 @param information 信息
 @param image 图片
 @param offset 图片下移位置
 @return 图片
 */
+ (UIImageView *)imageViewWithInformation:(NSString *)information
                                textColor:(UIColor *)textColor
                                    image:(UIImage *)image
                              imageOffset:(CGFloat)offset;

///子类复写
- (UIImageView *)imageViewThatNoMoreDataWithInformation:(NSString *)information
                                              textColor:(UIColor *)textColor
                                                  image:(UIImage *)image
                                            imageOffset:(CGFloat)offset
                                                 bgType:(eTableViewBg)bgType;
@end
