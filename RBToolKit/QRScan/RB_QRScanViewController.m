//
//  RB_QRScanViewController.m
//  Kiwi
//
//  Created by Ray on 2018/6/1.
//

#import "RB_QRScanViewController.h"

#import "RB_QRScanView.h"

#import "ReactiveObjC.h"

@interface RB_QRScanViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**  */
@property (nonatomic, strong)RB_QRScanView *scanView;


/**  */
@property (nonatomic, strong)RB_QRScanConfig *config;

/**  */
@property (nonatomic, strong)manageItem manageBarItem;

@end

@implementation RB_QRScanViewController

+ (instancetype)scan:(config)config album:(manageItem)album {
    RB_QRScanViewController *vc = [self scan:config];
    vc.manageBarItem = album;
    return vc;
}

+ (instancetype)scan:(config)config {
    
    RB_QRScanViewController *vc = [self new];
    
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
    
    self.scanView = [RB_QRScanView frame:self.view.bounds config:self.config.view];
    
    [self.view addSubview:self.scanView];
    
    @weakify(self)
    ///查询权限
    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {
        @strongify(self)
        
        if (pass) {
            ///如果权限允许 开启摄像头
            [[RB_QRScan scan] getReady:^(AVCaptureVideoPreviewLayer *layer) {
                [self.view.layer insertSublayer:layer atIndex:0];
            }];

            ///页面销毁 终止session
            [RB_QRScan scan].sessionStatus = self.rac_willDeallocSignal;
            
        }
        else {
            
            [self authorizationFailed:op];
            
        }
        
        ///扫描到
        [RB_QRScan scan].scanSomething = self.scanSomething;
        
    } option:eAuthorizeOptionCamera];
    
    
    
    ///是否需要 图片扫描
    if (self.config.albumManage) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(photoLibrary)];
        if (self.manageBarItem) {
            self.manageBarItem(item);
        }
        self.navigationItem.rightBarButtonItem = item;
    }

    ///管理 手电筒
    [[self.scanView.needFlash takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        [RB_Authorization flash:x.boolValue];
    }];
    
    ///确认手电筒关闭
    [self.rac_willDeallocSignal subscribeCompleted:^{
        [RB_Authorization flash:NO];
    }];
    
}


///相册选择照片 完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [RB_QRScan scan].imageDiscernment = info[UIImagePickerControllerOriginalImage];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[RB_QRScan scan] sessionRun:YES];
}




- (void)authorizationFailed:(eAuthorizeOption)option {

    RACTupleUnpack(NSString *info, NSString *confirm) = [self authorizationFailedInfo:option];
    
    UIAlertController *alert = [self authFailAlert:info confirm:confirm];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (RACTuple *)authorizationFailedInfo:(eAuthorizeOption)option {
    switch (option) {
        case eAuthorizeOptionCamera:
            return RACTuplePack(@"请在iPhone的“设置-隐私-相机”选项中，允许访问你的相机。", @"确认");
        case eAuthorizeOptionAlbum_read:
        case eAuthorizeOptionAlbum_read_write:
            return RACTuplePack(@"请在iPhone的“设置-隐私-相册”选项中，允许访问你的相册。", @"确认");
    }
    
}

- (void)photoLibrary {
    
    [RB_Authorization authorize:^(eAuthorizeOption op, BOOL pass) {

        if (pass) {
            [self imagePick];
        }
        else {
            self.navigationItem.rightBarButtonItem = nil;
            [self authorizationFailed:op];
        }

        
    } option:eAuthorizeOptionAlbum_read];
    
}





- (void)imagePick {
    
    [[RB_QRScan scan] sessionRun:NO];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (UIAlertController *)authFailAlert:(NSString *)info confirm:(NSString *)confirm {
    
    UIAlertController *authFailAlert = [UIAlertController alertControllerWithTitle:info message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [authFailAlert addAction:[UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:nil]];
    
    return authFailAlert;
}

@end
