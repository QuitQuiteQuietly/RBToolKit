//
//  QRScanView.m
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import "QRScanView.h"

#import "ReactiveObjC.h"
/** 扫描内容的 W 值 */
#define scanBorderW 0.7 * self.frame.size.width
/** 扫描内容的 x 值 */
#define scanBorderX 0.5 * (1 - 0.7) * self.frame.size.width
/** 扫描内容的 Y 值 */
#define scanBorderY 0.5 * (self.frame.size.height - scanBorderW)

@interface QRScanView ()
/**  */
@property (nonatomic, strong)QRScanViewConfig *config;

/**  */
@property (nonatomic, strong)UIView *contentView;

/** */
@property (nonatomic, strong)UIImageView *scanLine;

@end

@implementation QRScanView

+ (QRScanView *)frame:(CGRect)frame config:(QRScanViewConfig *)config {
    QRScanView *v = [[QRScanView alloc]initWithFrame:frame];
    v.config = config;
    return v;
}

- (QRScanViewConfig *)config {
    if (!_config) {
        _config = [QRScanViewConfig config];
    }
    return _config;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat borderW = scanBorderW;
    CGFloat borderH = borderW;
    CGFloat borderX = scanBorderX;
    CGFloat borderY = scanBorderY;
    
    /// 空白区域设置
    [[[UIColor blackColor] colorWithAlphaComponent:0.5] setFill];
    
    UIRectFill(rect);
    // 获取上下文，并设置混合模式 -> kCGBlendModeDestinationOut
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    // 设置空白区
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderX + 0.5 * self.config.maskBoxBoardWidth, borderY + 0.5 * self.config.maskBoxBoardWidth, borderW - self.config.maskBoxBoardWidth, borderH - self.config.maskBoxBoardWidth)];
    [bezierPath fill];
    // 执行混合模式
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    /// 边框设置
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderX, borderY, borderW, borderH)];
    borderPath.lineCapStyle = kCGLineCapButt;
    borderPath.lineWidth = self.config.maskBoxBoardWidth;
    [[UIColor clearColor] set];
    [borderPath stroke];
    
    [self drawLines:CGRectMake(scanBorderX, scanBorderY, borderW, borderH)];
}

- (void)drawLines:(CGRect)border {
    
    CGFloat x = border.origin.x;
    CGFloat y = border.origin.y;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.config.lineColor set];
    
    CGFloat lenght = self.config.lineLength;
    
    CGFloat right_x = CGRectGetMaxX(border);
    CGFloat right_y = CGRectGetMaxY(border);
    
    ///左上角
    [path moveToPoint:CGPointMake(x, y + lenght)];
    [path addLineToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(x + lenght, y)];
    
    ///左下角
    [path moveToPoint:CGPointMake(x + lenght, right_y)];
    [path addLineToPoint:CGPointMake(x, right_y)];
    [path addLineToPoint:CGPointMake(x, right_y - lenght)];
    
    ///右上角
    [path moveToPoint:CGPointMake(right_x - lenght, y)];
    [path addLineToPoint:CGPointMake(right_x, y)];
    [path addLineToPoint:CGPointMake(right_x, y + lenght)];
    
    ///右下角
    [path moveToPoint:CGPointMake(right_x, right_y - lenght)];
    [path addLineToPoint:CGPointMake(right_x, right_y)];
    [path addLineToPoint:CGPointMake(right_x - lenght, right_y)];
    
    [path stroke];
    
    [self freshUI:border];
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(scanBorderX, scanBorderY, scanBorderW, scanBorderW);
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (void)freshUI:(CGRect)rect {
    
    
    UIImage *image;
    if (!self.config.scanLine_display) { return; }

    if (self.config.scanLineImage) {
        image = self.config.scanLineImage;
    }
    else {
        image = [UIImage imageNamed:[[NSBundle bundleForClass:[self class]] pathForResource:@"QRCodeScanningLine@3x" ofType:@"png"]];
    }
    
    self.scanLine = [UIImageView new];

    self.scanLine.image = image;
//    [self addSubview:self.contentView];
    [self addSubview:self.scanLine];
    
    CGRect rectX = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 12);
    self.scanLine.frame = rectX;
    
    @weakify(self)
    
    static BOOL flag = YES;

    __block CGRect frame = rectX;
    
    [[[RACSignal interval:0.02 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self)
        if (flag) {
            frame.origin.y = scanBorderY;
            flag = NO;
            [UIView animateWithDuration:0.02 animations:^{
                frame.origin.y += 3;
                self.scanLine.frame = frame;
            } completion:nil];
        } else {
            if (self.scanLine.frame.origin.y >= scanBorderY) {
                CGFloat scanContent_MaxY = scanBorderY + self.frame.size.width - 2 * scanBorderX;
                if (self.scanLine.frame.origin.y >= scanContent_MaxY - 10) {
                    frame.origin.y = scanBorderY;
                    self.scanLine.frame = frame;
                    flag = YES;
                }
                else {
                    [UIView animateWithDuration:0.02 animations:^{
                        frame.origin.y += 3;
                        self.scanLine.frame = frame;
                    } completion:nil];
                }
            } else {
                flag = !flag;
            }
        }
    }];
}


@end

@implementation QRScanViewConfig

+ (QRScanViewConfig *)config {
    QRScanViewConfig *c = [QRScanViewConfig new];
    c.lineWidth = 2;
    c.lineColor = [UIColor whiteColor];
    c.lineLength = 20;
    c.maskBoxBoardWidth = .2;
    c.maskBoxBoardColor = [UIColor whiteColor];
    c.scanLine_display = YES;
    return c;
}


@end
