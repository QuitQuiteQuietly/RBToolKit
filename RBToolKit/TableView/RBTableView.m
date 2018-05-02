//
//  RBTableView.m
//  Kiwi
//
//  Created by Ray on 2018/5/2.
//

#import "RBTableView.h"

#import "MJRefresh.h"
#import "ReactiveObjC.h"

@interface RBTableView ()

@property (nonatomic, readwrite, assign)NSInteger refreshIndex;

/**  */
@property (nonatomic, readwrite, strong)UIImageView *noMoreDataView;
@property (nonatomic, readwrite, strong)UIImageView *networkWrongView;

@end

@implementation RBTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    _refreshFooterEnable = YES;
    _refreshHeaderEnable = YES;
}

- (instancetype)initWithStyle:(UITableViewStyle)style refreshBlock:(void (^)(BOOL, NSInteger))refreshBlock {
    self = [super initWithFrame:CGRectZero style:style];
    if (self) {
        _refresh = refreshBlock;
        _refreshFooterEnable = YES;
        _refreshHeaderEnable = YES;
        [self setupMJRefresh];
    }
    return self;
}

- (void)startRefresh {
    if (self.refresh) {
        self.refreshIndex = 0;
        self.refresh(YES, self.refreshIndex);
    }
}

//- (void)endRefreshAndRequestSuccess:(BOOL)success lastCount:(NSInteger)noMoreData displayNoData:(NSInteger)hidden {
//    self.backgroundView = (hidden > 0) ? nil : self.noMoreDataView;
//    [self endRefreshAndRequestSuccess:success withNoMoreData:(noMoreData < PageSize.integerValue)];
//}

- (void)endRefreshAndRequestSuccess:(BOOL)success withNoMoreData:(BOOL)noMoreData isEmpty:(BOOL)isEmpty {
    
    [self reloadData];
    
    if (success && !noMoreData) {
        self.refreshIndex ++;
    }
    
    if (noMoreData) {
        [self endRefreshWithNoMoreData];
    }
    else {
        [self endRefresh];
    }
    
    [self setBackGroundViewWithNetwork:success isEmpty:isEmpty];
    
}

- (void)setBackGroundViewWithNetwork:(BOOL)success isEmpty:(BOOL)isEmpty {
    if (!success && self.networkWrongView) {
        ///网络错误
        self.backgroundView = self.networkWrongView;
        return;
    }
    self.backgroundView = isEmpty ? self.noMoreDataView : nil;
}

- (void)endRefresh {
    [self headEndFresh];
    if (self.mj_footer) {
        [self.mj_footer  endRefreshing];
    }
}

- (void)headEndFresh {
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
}

- (void)endRefreshWithNoMoreData {
    [self headEndFresh];
    if (self.mj_footer) {
        [self.mj_footer  endRefreshingWithNoMoreData];
    }
}

- (void)rb_mj_refreshBlock:(void (^)(BOOL, NSInteger))refreshBlock headerEnable:(BOOL)header footerEnable:(BOOL)footer {
    _refresh = refreshBlock;
    _refreshHeaderEnable = header;
    _refreshFooterEnable = footer;
    [self setupMJRefresh];
}

- (void)setupMJRefresh {
    @weakify(self)
    if (!self.mj_header && _refreshHeaderEnable) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            
            if (self.mj_footer && (self.mj_footer.state == MJRefreshStateRefreshing)) {
                return;
            }
            
            if (self.refresh) {
                self.refreshIndex = 0;
                self.refresh(YES, self.refreshIndex);
            }
        }];
    }
    if (!self.mj_footer && _refreshFooterEnable) {
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            
            if (self.mj_header && (self.mj_header.state == MJRefreshStateRefreshing)) {
                return;
            }
            
            if (self.refreshIndex == 0) {
                [self.mj_footer endRefreshing];
                return;
            }
            
            if (self.refresh) {
                self.refresh(NO, self.refreshIndex);
            }
        }];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview == nil) {
        return;
    }
    [self setupMJRefresh];
}

- (NSInteger)currentPageIndex {
    return self.refreshIndex;
}

- (NSInteger)refreshIndex {
    if (!_refreshIndex) {
        _refreshIndex = 0;
    }
    return _refreshIndex;
}

- (void)setRefreshHeaderEnable:(BOOL)refreshHeaderEnable {
    _refreshHeaderEnable = refreshHeaderEnable;
    self.mj_header = _refreshHeaderEnable ? self.mj_header : nil;
}

- (void)setRefreshFooterEnable:(BOOL)refreshFooterEnable {
    _refreshFooterEnable = refreshFooterEnable;
    self.mj_footer = _refreshFooterEnable ? self.mj_footer : nil;
}


- (void)setRefresh:(refreshBlock)refresh {}

- (UIImageView *)noMoreDataView {
    if (!_noMoreDataView) {
        _noMoreDataView = [RBTableView imageViewThatNoMoreDataWithInformation:@"" image:nil imageOffset:0 bgType:eTableViewBgNoData];
    }
    return _noMoreDataView;
}
- (UIImageView *)networkWrongView {
    if (!_networkWrongView) {
        _networkWrongView = [RBTableView imageViewThatNoMoreDataWithInformation:@"" image:nil imageOffset:0 bgType:eTableViewBgNetGoesWrong];
    }
    return _networkWrongView;
}

+ (UIImageView *)imageViewThatNoMoreDataWithInformation:(NSString *)information image:(UIImage *)image imageOffset:(CGFloat)offset bgType:(eTableViewBg)bgType {
    return [self imageViewWithInformation:information image:image imageOffset:offset];
}

+ (UIImageView *)imageViewWithInformation:(NSString *)information image:(UIImage *)image imageOffset:(CGFloat)offset
{
    NSString * finalMessage = @"";
    if (information.length)
    {
        finalMessage = information;
    }
    CGFloat defaultOffset = 80.0f;
    defaultOffset = (offset > 0.0f) ? offset : 80.0f;
    
    CGSize canvasSize = [UIScreen mainScreen].bounds.size;
    
    //    if (!image) {
    ///默认图片
    //        image = [UIImage imageNamed:@"IMAGE_NO_MORE_INFOMATION"];
    
    //    }
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    
    ///绘制文字 到 图片上
    //        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height + 60), NO, 0.0);
    
    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, 0.0);
    
    CGFloat canvasCenterX = canvasSize.width / 2;
    CGFloat canvasCenterY = canvasSize.height / 2;
    CGFloat imageTopY =  canvasCenterY - (image.size.height / 2) - defaultOffset;
    
    
    [image drawAtPoint:CGPointMake(canvasCenterX - (image.size.width / 2), imageTopY)];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    UIFont * font = [UIFont systemFontOfSize:14];
    
    CGFloat strWidth = [finalMessage boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size.width;
    
    [finalMessage drawAtPoint : CGPointMake (canvasCenterX - strWidth / 2, imageTopY + image.size.height + 10)
               withAttributes : @{NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : [UIColor blackColor],
                                  }];
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    imageView.image = newImage;
    
    
    return imageView;
}

@end
