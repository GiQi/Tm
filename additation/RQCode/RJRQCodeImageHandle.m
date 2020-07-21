 //
//  RJRQCodeImageHandle.m
//  JDSGZ-mobile
//
//  Created by Apple on 2020/4/22.
//

#import "RJRQCodeImageHandle.h"

@implementation RJRQCodeImageHandle
//获取二维码图片本地路径
+(NSString *)getPathOfRQCodeImage:(NSString *)url
{

    NSString *path = [self saveImageToLocation:[self setUIQRCode:url]];
    
    return path;

}

//生成二维码
+(UIImage*)setUIQRCode:(NSString*)url
{
    //创建
    CIFilter *QRCodeFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复默认
    [QRCodeFilter setDefaults];
    //给filter添加数据
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    [QRCodeFilter setValue:data forKey:@"inputMessage"];
    
    //获取输出的二维码
    CIImage *outPutImage = [QRCodeFilter outputImage];
    
    //将CIImage 转换UIImage
    return [self createNonInterpolatedUIImageFormCIImage:outPutImage withSize:100];
    
}

//转换图片
+(UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

//保存生成的二维码到本地
+(NSString *)saveImageToLocation:(UIImage*)saveImage
{
    UIImage *image = saveImage;
    NSString *path = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *imgPath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"RQCodeImage.png"]];
    BOOL result = [UIImagePNGRepresentation(image)writeToFile:imgPath atomically:YES];
    if (result) {
        NSLog(@"saved successfully");
        path = imgPath;
    }
    
    return path;
}

@end
