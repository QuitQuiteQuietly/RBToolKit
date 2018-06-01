//
//  RB_Authorization.m
//  Kiwi
//
//  Created by Ray on 2018/5/31.
//

#import "RB_Authorization.h"

#import <Photos/Photos.h>

typedef void(^decision)(BOOL decision);

@implementation RB_Authorization


+ (void)authorize:(pass)process option:(eAuthorizeOption)option {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device) { return; }

    
    BOOL camera = option & eAuthorizeOptionCamera;
    

    if (camera) {
        [RB_Authorization checkCamera:^(BOOL decision) {
            if (process) {
                process(eAuthorizeOptionCamera, decision);
            }
            if (option & eAuthorizeOptionAlbum_read || option & eAuthorizeOptionAlbum_read_write) {
                [RB_Authorization aboutAlbum:option process:process];
            }
        }];
    }
    else {
        
        [RB_Authorization aboutAlbum:option process:process];
        
    }
}

+ (void)checkCamera:(decision)decision {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    BOOL success = NO;
    
    switch (status) {
            
        case PHAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                [RB_Authorization finalDecision:decision success:granted];
            }];
            
            return;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            break;
        case PHAuthorizationStatusAuthorized:
            success = YES;
            break;
    }
    
    [RB_Authorization finalDecision:decision success:success];
}

+ (void)aboutAlbum:(eAuthorizeOption)option process:(pass)process {

    BOOL read = option & eAuthorizeOptionAlbum_read;
    
    if (@available(iOS 11_0, *)) {
        ///ios 11  不再需要询问 读取 相册的权限
        if (read) {
            if (process) {
                process(eAuthorizeOptionAlbum_read, YES);
            }
        }
        
        if (!(option & eAuthorizeOptionAlbum_read_write)) {
            return;
        }
        
    }
    
    
    BOOL album = option & eAuthorizeOptionAlbum_read_write || option & eAuthorizeOptionAlbum_read;

    if (album) {

        [RB_Authorization checkAlbum:^(BOOL decision) {
            if (process) {
                process(eAuthorizeOptionAlbum_read_write, decision);
            }
        }];

    }
    else {
        if (process) {
            process(eAuthorizeOptionAlbum_read_write, NO);
        }
    }
}

+ (void)checkAlbum:(decision)decision  {
    PHAuthorizationStatus checkStatus = [PHPhotoLibrary authorizationStatus];
    __block BOOL success = NO;

    switch (checkStatus) {
            
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
                switch (status) {
                    case PHAuthorizationStatusNotDetermined:
                    case PHAuthorizationStatusRestricted:
                    case PHAuthorizationStatusDenied:
                        break;
                    case PHAuthorizationStatusAuthorized:
                        success = YES;
                        break;
                }
                
                [RB_Authorization finalDecision:decision success:success];
                
                return;
            }];
            
            ///禁止 在未决定的时候 走到 [RB_Authorization finalDecision:decision success:success]; 上
            return;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            break;
        case PHAuthorizationStatusAuthorized:
            success = YES;
            break;
            
    }
    
    [RB_Authorization finalDecision:decision success:success];
   
}


+ (void)finalDecision:(decision)decision success:(BOOL)success {
    
    if (decision) {
        dispatch_async(dispatch_get_main_queue(), ^{
            decision(success);
        });
    }
    
}


@end


@implementation RB_Authorization (Flash)

+ (void)flash:(BOOL)on {
    
    [self flash:on error:nil];
    
}

+ (void)flash:(BOOL)on error:(NSError *__autoreleasing *)error {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch]) {
        
        BOOL locked = [device lockForConfiguration:error];
        if (locked) {
            
            AVCaptureTorchMode mode = on ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
            
            if (device.torchMode != mode) {
                device.torchMode = mode;
            }
            
            [device unlockForConfiguration];
        }
    }
    
}

@end
