//
//  RBTableView.h
//  Kiwi
//
//  Created by Ray on 2018/5/2.
//

#import <UIKit/UIKit.h>

typedef void(^refreshBlock)(BOOL isHeader, NSInteger pageIndex);

typedef NS_ENUM(NSUInteger, eTableViewBg) {
    eTableViewBgNoData,
    eTableViewBgNetGoesWrong
};

@interface RBTableView : UITableView


- (instancetype)initWithStyle:(UITableViewStyle)style refreshBlock:(refreshBlock)refreshBlock;

///内部拥有set方法，防止复写
@property (nonatomic, readonly, copy)refreshBlock refresh;


/**
 当 拉动 tableview 时
 
 @param refreshBlock ""
 */
- (void)rb_mj_refreshBlock:(refreshBlock)refreshBlock headerEnable:(BOOL)header footerEnable:(BOOL)footer;

/**
 结束刷新状态
 
 @param success 请求是否成功（影响自身的PageIndex）
 @param noMoreData 是否无更多数据
 */
- (void)endRefreshAndRequestSuccess:(BOOL)success
                     withNoMoreData:(BOOL)noMoreData
                            isEmpty:(BOOL)isEmpty;
- (void)endRefreshWithNoMoreData;

///首次请求--会将isHeader和pageIndex都置为0
- (void)startRefresh;

///refreshHeader是否可用 default : YES
@property (nonatomic, readwrite, assign)BOOL refreshHeaderEnable;
///refreshFooter是否可用 default : YES
@property (nonatomic, readwrite, assign)BOOL refreshFooterEnable;

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
                                    image:(UIImage *)image
                              imageOffset:(CGFloat)offset;


+ (UIImageView *)imageViewThatNoMoreDataWithInformation:(NSString *)information
                                                  image:(UIImage *)image
                                            imageOffset:(CGFloat)offset
                                                 bgType:(eTableViewBg)bgType;
@end
