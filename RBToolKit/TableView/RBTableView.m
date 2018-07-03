//
//  RBTableView.m
//  Kiwi
//
//  Created by Ray on 2018/5/2.
//

#import "RBTableView.h"

#import "MJRefresh.h"
#import "ReactiveObjC.h"

#import "RBTableViewConfig.h"

@interface RBTableView ()

@property (nonatomic, readwrite, assign)NSInteger refreshIndex;

/**  */
@property (nonatomic, strong)RB_Refresh <MJRefreshNormalHeader *> *rb_header;
@property (nonatomic, strong)RB_Refresh <MJRefreshBackNormalFooter *> *rb_footer;

/**  */
@property (nonatomic, readwrite, strong)UIImageView *noMoreDataView;
@property (nonatomic, readwrite, strong)UIImageView *networkWrongView;

/** 响应几次 */
@property (nonatomic, strong)FreshTakes *headerTakes;
@property (nonatomic, strong)FreshTakes *footerTakes;
/** 最近一次的刷新 是什么位置 */
@property (nonatomic, assign)eRBTV_Dir latest_refresh;

@end

@implementation RBTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self allAvailableHeader:NO :NO];
}

- (instancetype)initWithStyle:(UITableViewStyle)style refresh:(refresh)refresh {
    self = [super initWithFrame:CGRectZero style:style];
    if (self) {
        self.refresh = refresh;
        [self allAvailableHeader:YES :YES];
        [self setupMJRefresh];
    }
    return self;
}

- (void)allAvailableHeader:(BOOL)h :(BOOL)f {
    self.rb_header.enable = h;
    self.rb_footer.enable = f;
}

- (void)startRefresh {
    [self startRefresh:YES];
}

- (void)startRefresh:(BOOL)pullAnimate {
    if (self.refresh) {
        
        self.refreshIndex = 0;
        
        if (!pullAnimate) {
            self.refresh(YES, self.refreshIndex, self);
        }
        else {
            [self.rb_header trigger];
        }
    }
}

- (void)trigger_refresh:(eRBTV_Dir)dir {
    
    if (!self.refresh) { return; }
    
    self.latest_refresh = dir;
    
    self.refresh(dir & eRBTV_DirHeader, self.refreshIndex, self);
}

- (void)setLatest_refresh:(eRBTV_Dir)latest_refresh {
    _latest_refresh = latest_refresh;
    ///如果是头。置零
    if (_latest_refresh & eRBTV_DirHeader) { self.refreshIndex = 0; }
}


- (void)endRefreshAndRequestSuccess:(BOOL)success withNoMoreData:(BOOL)noMoreData isEmpty:(BOOL)isEmpty {
    
    [self reloadData];
    
    if (success) {
        if (!noMoreData) { self.refreshIndex ++; }
    }

    [self endRefresh:noMoreData];
    
    ///如果成功 是否需要出触发takes
    if (success) {
        ///计数需要等到 refresh 结束
        [self trigger_takes];
    }
    
    [self setBackGroundViewWithNetwork:success isEmpty:isEmpty];
    
}

- (void)trigger_takes {

    if (self.latest_refresh & eRBTV_DirHeader) {
        if (self.headerTakes) {
            self.rb_header.enable = [self.headerTakes do_take];
        }

        if (self.footerTakes && self.footerTakes.resetAble) {
            ///是否需要重置 尾部计数器
            self.rb_footer.enable = [self.footerTakes reset];
        }
    }
    else if (self.latest_refresh & eRBTV_DirFooter) {
        if (!self.footerTakes) { return; }
        self.rb_footer.enable = [self.footerTakes do_take];
    }
    
}


- (void)setBackGroundViewWithNetwork:(BOOL)success isEmpty:(BOOL)isEmpty {
    if (!success && self.networkWrongView) {
        ///网络错误
        self.backgroundView = self.networkWrongView;
        return;
    }
    self.backgroundView = isEmpty ? self.noMoreDataView : nil;
}

- (void)endRefresh:(BOOL)displayNoMoreData {
    [self header_end_refresh];
    [self footer_end_refresh:displayNoMoreData];
}

- (void)footer_end_refresh:(BOOL)displayNoMoreData {
    if (self.rb_footer.enable) {
        if (displayNoMoreData) {
            [self.rb_footer.refresh  endRefreshingWithNoMoreData];
            return;
        }
        [self.rb_footer.refresh endRefreshing];
    }
}

- (void)header_end_refresh {
    if (self.rb_header.enable) {
        [self.rb_header.refresh endRefreshing];
    }
}

- (void)rb_mj_refresh:(refresh)refresh enableHeader:(BOOL)header footer:(BOOL)footer {
    _refresh = refresh;
    [self allAvailableHeader:header :footer];
    [self setupMJRefresh];
}

- (void)rb_mj_refresh:(refresh)refresh enable:(eRBTV_Dir)dir {
    [self rb_mj_refresh:refresh enableHeader:(dir & eRBTV_DirHeader) footer:(dir & eRBTV_DirFooter)];
}

- (RBTableView *)rb_mj_refresh:(refresh)refresh {
    [self rb_mj_refresh:refresh enableHeader:YES footer:YES];
    return self;
}

- (RBTableView *(^)(eRBTV_Dir))enable {
    return ^RBTableView *(eRBTV_Dir dir) {
        self.rb_header.enable = dir & eRBTV_DirHeader;
        self.rb_footer.enable = dir & eRBTV_DirFooter;
        
        return self;
    };
}

- (void)setupMJRefresh {
    
    if (UITableViewStylePlain == self.style) {
        self.tableFooterView = [UIView new];
    }
    if (!self.mj_header) {
        self.mj_header = self.rb_header.refresh;
    }
    if (!self.mj_footer) {
        self.mj_footer = self.rb_footer.refresh;
    }
}

- (RB_Refresh<MJRefreshBackNormalFooter *> *)rb_footer {
    if (!_rb_footer) {
        @weakify(self)
            
        _rb_footer = [RB_Refresh<MJRefreshBackNormalFooter *> refresh:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            
            if (self.mj_header && (self.mj_header.state == MJRefreshStateRefreshing)) {
                return;
            }
            
            if (self.refreshIndex == 0) {
                [self.mj_footer endRefreshing];
                return;
            }
            [self trigger_refresh:eRBTV_DirFooter];
        }] delay:^(MJRefreshBackNormalFooter *refresh) {
            if (refresh) {
                [refresh beginRefreshing];
            }
        } disable:^(BOOL disable, MJRefreshBackNormalFooter *refresh) {
            @strongify(self)
            self.mj_footer.hidden = disable;
        }];
    }
    return _rb_footer;
}

- (RB_Refresh<MJRefreshNormalHeader *> *)rb_header {
    if (!_rb_header) {
        @weakify(self)
        
        MJRefreshNormalHeader *h = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            if (self.mj_footer && (self.mj_footer.state == MJRefreshStateRefreshing)) {
                return;
            }
            [self trigger_refresh:eRBTV_DirHeader];
        }];
        h.endRefreshingCompletionBlock = ^{
            
        };
        
        _rb_header = [RB_Refresh<MJRefreshNormalHeader *> refresh:h delay:^(MJRefreshNormalHeader *refresh) {
            if (refresh) {
                [refresh beginRefreshing];
            }
        } disable:^(BOOL disable, MJRefreshNormalHeader *refresh) {
            @strongify(self)
            self.mj_header.hidden = disable;
        }];
        
    }
    return _rb_header;
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

- (void)setRefresh:(refresh)refresh {}

- (UIImageView *)noMoreDataView {
    if (!_noMoreDataView) {
        _noMoreDataView = [self imageViewThatNoMoreDataWithInformation:@"" textColor:[UIColor blackColor] image:nil imageOffset:0 bgType:eTableViewBgNoData];
    }
    return _noMoreDataView;
}
- (UIImageView *)networkWrongView {
    if (!_networkWrongView) {
        _networkWrongView = [self imageViewThatNoMoreDataWithInformation:@"" textColor:[UIColor blackColor] image:nil imageOffset:0 bgType:eTableViewBgNetGoesWrong];
    }
    return _networkWrongView;
}

- (UIImageView *)imageViewThatNoMoreDataWithInformation:(NSString *)information textColor:(UIColor *)textColor image:(UIImage *)image imageOffset:(CGFloat)offset bgType:(eTableViewBg)bgType {
    return [RBTableView imageViewWithInformation:information textColor:textColor image:image imageOffset:offset];
}

+ (UIImageView *)imageViewWithInformation:(NSString *)information textColor:(UIColor *)textColor image:(UIImage *)image imageOffset:(CGFloat)offset {
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
                                  NSForegroundColorAttributeName : textColor,
                                  }];
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    imageView.image = newImage;
    
    
    return imageView;
}

- (void)dealloc {
    NSLog(@"tableView %@", self);
}

@end


@implementation RBTableView (Takes)

- (__kindof RBTableView *(^)(NSInteger, eRBTV_Dir))take {
    return ^RBTableView *(NSInteger times, eRBTV_Dir dir) {
        
        ///头部 不允许重置
        self.takeWithReset(times, dir & eRBTV_DirHeader ? NO : YES, dir);

        return self;
        
    };
}

- (__kindof RBTableView *(^)(NSInteger, BOOL, eRBTV_Dir))takeWithReset {
    
    return ^RBTableView *(NSInteger times, BOOL reset, eRBTV_Dir dir) {
        
        FreshTakes *take = [FreshTakes take:times resetAble:reset];
        
        if (dir & eRBTV_DirHeader) {
            self.headerTakes = take;
        }
        if (dir & eRBTV_DirFooter) {
            self.footerTakes = take;
        }
        
        return self;
        
    };
 
}

@end







