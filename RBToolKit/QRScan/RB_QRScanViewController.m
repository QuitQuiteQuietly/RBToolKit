//
//  RB_QRScanViewController.m
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import "RB_QRScanViewController.h"

#import "RB_QRScan.h"

#import "QRScanView.h"

#import "ReactiveObjC.h"

#import "RB_Authorization.h"

@interface RB_QRScanViewController ()

/**  */
@property (nonatomic, strong)QRScanView *scanView;


/**  */
@property (nonatomic, strong)RB_QRScanConfig *config;

/**  */
@property (nonatomic, strong)manageItem manageBarItem;

@end

@implementation RB_QRScanViewController

+ (RB_QRScanViewController *)scan:(config)config album:(manageItem)album {
    RB_QRScanViewController *vc = [RB_QRScanViewController scan:config];
    vc.manageBarItem = album;
    return vc;
}

+ (RB_QRScanViewController *)scan:(config)config {
    
    RB_QRScanViewController *vc = [RB_QRScanViewController new];
    
    RB_QRScanConfig *normal = [RB_QRScanConfig config];
    
    if (config) {
        RB_QRScanConfig *c = config(normal);
        if (c) { normal = c; }
    }
    
    vc.config = normal;
    
    return vc;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.scanView = [QRScanView frame:self.view.bounds config:self.config.view];
    
    ///管理 手电筒
    [[self.scanView.needFlash takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        [RB_Authorization flash:x.boolValue];
    }];
    
    [self.view addSubview:self.scanView];
    
    @weakify(self)
    ///查询权限
    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {
        @strongify(self)
        
        if (op == eAuthorizeOptionCamera && pass) {
            ///如果权限允许 开启摄像头
            [[RB_QRScan scan] getReady:^(AVCaptureVideoPreviewLayer *layer) {
                [self.view.layer insertSublayer:layer atIndex:0];
            }];

            
            [RB_QRScan scan].sessionStatus = self.rac_willDeallocSignal;
            
        }
        
    } option:eAuthorizeOptionCamera];
    
    ///是否需要 图片扫描
    if (self.config.albumManage) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoLibrary)];
        if (self.manageBarItem) {
            self.manageBarItem(item);
        }
        self.navigationItem.rightBarButtonItem = item;
    }

    ///确认手电筒关闭
    [self.rac_willDeallocSignal subscribeCompleted:^{
        [RB_Authorization flash:NO];
    }];
    
}

- (void)photoLibrary {
    
    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {

        NSLog(@"%d", pass);
        if (!pass) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
    } option:eAuthorizeOptionAlbum_read];
    
}


@end
