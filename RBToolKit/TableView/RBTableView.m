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

///refreshHeader是否可用 default : YES
@property (nonatomic, readwrite, assign)BOOL refreshHeaderEnable;
///refreshFooter是否可用 default : YES
@property (nonatomic, readwrite, assign)BOOL refreshFooterEnable;

/** 响应几次 */
@property (nonatomic, strong)RACTwoTuple <NSNumber *, NSNumber *>*headerTakes;
@property (nonatomic, strong)RACTwoTuple <NSNumber *, NSNumber *>*footerTakes;
/** 最近一次的刷新 是什么位置 */
@property (nonatomic, assign)eRBTV_Dir latest_refresh;

@end

@implementation RBTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    _refreshFooterEnable = YES;
    _refreshHeaderEnable = YES;
}

- (instancetype)initWithStyle:(UITableViewStyle)style refresh:(refresh)refresh {
    self = [super initWithFrame:CGRectZero style:style];
    if (self) {
        self.refresh = refresh;
        self.refreshFooterEnable = YES;
        self.refreshHeaderEnable = YES;
        [self setupMJRefresh];
    }
    return self;
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
            if (self.refreshHeaderEnable) {
                [self.mj_header beginRefreshing];
            }
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
        ///如果成功 是否需要出触发takes
        [self trigger_takes];
    }

    [self endRefresh:noMoreData];
    
    [self setBackGroundViewWithNetwork:success isEmpty:isEmpty];
    
}

- (void)trigger_takes {

    if (self.latest_refresh & eRBTV_DirHeader) {
        if (!self.headerTakes) { return; }
        RACTupleUnpack(NSNumber *con, RACTwoTuple *info) = [self continueTakes:self.headerTakes];
        self.refreshHeaderEnable = con.boolValue;
        self.headerTakes = info;
    }
    else if (self.latest_refresh & eRBTV_DirFooter) {
        if (!self.footerTakes) { return; }
        RACTupleUnpack(NSNumber *con, RACTwoTuple *info) = [self continueTakes:self.footerTakes];
        self.refreshFooterEnable = con.boolValue;
        self.footerTakes = info;
    }
    
}

- (RACTwoTuple <NSNumber *, RACTwoTuple *>*)continueTakes:(RACTwoTuple <NSNumber *, NSNumber *> *)package {
    BOOL take = package.first.boolValue;
    
    NSInteger times = package.second.integerValue;
    times --;
    
    BOOL continueTakes = take && times > 0;
    if (!continueTakes) {
        package = nil;
    }
    else {
        package = [RACTwoTuple tupleWithObjectsFromArray:@[@(take), @(times)]];
    }
    return [RACTwoTuple tupleWithObjectsFromArray:@[@(continueTakes), package] convertNullsToNils:YES];
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
    if (self.mj_footer) {
        if (displayNoMoreData) {
            [self.mj_footer  endRefreshingWithNoMoreData];
            return;
        }
        [self.mj_footer endRefreshing];
    }
}

- (void)header_end_refresh {
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
}

- (void)rb_mj_refresh:(refresh)refresh enableHeader:(BOOL)header footer:(BOOL)footer {
    _refresh = refresh;
    _refreshHeaderEnable = header;
    _refreshFooterEnable = footer;
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
      
        if (dir & eRBTV_DirHeader) {
            self.refreshHeaderEnable = YES;
        }
        if (dir & eRBTV_DirFooter) {
            self.refreshFooterEnable = YES;
        }
        
        return self;
    };
}

- (void)setupMJRefresh {
    
    
    if (UITableViewStylePlain == self.style) {
        self.tableFooterView = [UIView new];
    }
    
    
    @weakify(self)
    if (!self.mj_header && _refreshHeaderEnable) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            
            if (self.mj_footer && (self.mj_footer.state == MJRefreshStateRefreshing)) {
                return;
            }
            [self trigger_refresh:eRBTV_DirHeader];
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
            [self trigger_refresh:eRBTV_DirFooter];
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

@end


@implementation RBTableView (Takes)

- (RBTableView *(^)(NSInteger, eRBTV_Dir))take {
    return ^RBTableView *(NSInteger times, eRBTV_Dir dir) {
        
        if (dir & eRBTV_DirHeader) {
            self.headerTakes = [RACTwoTuple tupleWithObjectsFromArray:@[@(YES), @(times)]];
        }
        if (dir & eRBTV_DirFooter) {
            self.footerTakes = [RACTwoTuple tupleWithObjectsFromArray:@[@(YES), @(times)]];
        }
      
        return self;
        
    };
}

@end
