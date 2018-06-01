
//
//  RB_QRScan.m
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import "RB_QRScan.h"

#import "ReactiveObjC.h"

@interface RB_QRScan ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

/** 摄像数据输出流 */
@property (nonatomic, strong)AVCaptureVideoDataOutput *video_data_Output;

@property (nonatomic, strong) AVCaptureSession *session;

/** 亮度 */
@property (nonatomic, assign)NSInteger brightness;

@end

static RB_QRScan *_scan;

@implementation RB_QRScan


+ (RB_QRScan *)scan {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _scan = [RB_QRScan new];
    });
    return _scan;
}

- (AVCaptureVideoDataOutput *)video_data_Output {
    if (!_video_data_Output) {
        ///创建摄像数据输出流
        _video_data_Output = [AVCaptureVideoDataOutput new];
        // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
        // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）;
        // 如需限制扫描框范围，打开下一句注释代码并进行相应调整
        //    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    }
    return _video_data_Output;
}

- (void)setImageDiscernment:(UIImage *)imageDiscernment {
    
    if (!imageDiscernment) { return; }
    
    // 对选取照片的处理，如果选取的图片尺寸过大，则压缩选取图片，否则不作处理
    UIImage *image = [RB_QRScan SG_imageSizeWithScreenImage:imageDiscernment];
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    NSString *result;
    
    if (features.count == 0) {
        result = @"";
    } else {
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            result = feature.messageString;
        }
    }
    
    [self doSomething:result];

}


- (void)getReady:(void (^)(AVCaptureVideoPreviewLayer *))layer {
    
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建摄像设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
 
    // 3、创建元数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    

    
    // 4、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 会话采集率: AVCaptureSessionPresetHigh
    AVCaptureSessionPreset p = AVCaptureSessionPreset1920x1080;
    _session.sessionPreset = p;
    
    // 5、添加元数据输出流到会话对象
    [_session addOutput:metadataOutput];
    // 5(1)添加摄像输出流到会话对象；与 3(1) 构成识了别光线强弱
    [_session addOutput:self.video_data_Output];
    [self setSampleBuffer:YES];
    
    // 6、添加摄像设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    metadataOutput.metadataObjectTypes = arr;
    
    
    if (layer) {
        // 8、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
        AVCaptureVideoPreviewLayer *_videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        // 保持纵横比；填充层边界
        _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        _videoPreviewLayer.frame = CGRectMake(x, y, w, h);
        layer(_videoPreviewLayer);
    }
    
    // 9、启动会话
    [self sessionRun:YES];
    
}

- (void)sessionRun:(BOOL)run {
    if (run) {
        [self.session startRunning];
    }
    else {
        [self.session stopRunning];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *msg = [metadataObjects.firstObject stringValue];
    
    [self doSomething:msg];
}

- (void)doSomething:(NSString *)result {
    
    if (self.scanSomething) {
        
        BOOL stop = YES;
        
        [self sessionRun:NO];
        
        self.scanSomething(result, &stop);
        
        if (!stop) {
            [self sessionRun:YES];
        }
    }
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 这个方法会时时调用，但内存很稳定
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    NSInteger brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] integerValue];
    self.brightness = brightnessValue;  
}

- (void)setSampleBuffer:(BOOL)set {
    [self.video_data_Output setSampleBufferDelegate:set ? self : nil queue:dispatch_get_main_queue()];
}

- (void)setSessionStatus:(RACSignal *)sessionStatus {
    
    _sessionStatus = sessionStatus;
    @weakify(self)
    [[_sessionStatus take:1] subscribeCompleted:^{
        @strongify(self)
        [self setSampleBuffer:NO];
        [self sessionRun:NO];
    }];
    
}

- (RACSignal *)flashOn {
    
    if (!_flashOn) {
        _flashOn = [[RACObserve(self, brightness) distinctUntilChanged] map:^id _Nullable(NSNumber  *_Nullable value) {
            return @(value.integerValue < -1);
        }];
    }
    return _flashOn;
}


/// 返回一张不超过屏幕尺寸的 image
+ (UIImage *)SG_imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGSize screen = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = screen.width;
    CGFloat screenHeight = screen.height;
    
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
