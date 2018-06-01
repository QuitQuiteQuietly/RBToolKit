//
//  RB_QRGenerate.m
//  MJRefresh
//
//  Created by Ray on 2018/5/31.
//

#import "RB_QRGenerate.h"

@implementation RB_QRGenerate

+ (UIImage *)qr_info:(NSString *)info width:(CGFloat)width {
    
    ///滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [filter setDefaults];
    
    NSData *data = [info dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    CIImage *image = [filter outputImage];
    
    return [RB_QRGenerate trans:image width:width];
}







+ (UIImage *)trans:(CIImage *)ciimage width:(CGFloat)width {
    
    CGRect extent = CGRectIntegral(ciimage.extent);
    
    CGFloat scale = MIN(width / CGRectGetWidth(extent), width / CGRectGetHeight(extent));
    
    size_t width_t = CGRectGetWidth(extent) * scale;
    size_t height_t = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width_t, height_t, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    ///保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}

@end
