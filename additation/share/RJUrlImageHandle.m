//
//  RJUrlImageHandle.m
//  TestDemo-mobile
//
//  Created by Apple on 2020/5/28.
//

#import "RJUrlImageHandle.h"
#import <Photos/Photos.h>

@interface RJUrlImageHandle()
@property(nonatomic,copy)NSMutableArray *selectedPhotos;
@property(nonatomic,copy)NSMutableArray *selectedAssets;

@end

@implementation RJUrlImageHandle
-(void)initWithFloderName
{
    
}

/**
 根据URL获取UIImage实例
 @param picUrl 传入的图片URL
 */
- (UIImage *)addImageViewTolocal:(NSString *)picUrl{
    UIImage *image1 = [UIImage imageNamed:picUrl];
//    NSData *imageData = [NSData dataWithContentsOfFile:picUrl];
//    UIImage *myImage = [UIImage imageWithData:imageData];
    return image1;
}


/**
 调用UIImageWriteToSavedPhotosAlbum方法
 @param savedImage 第一步的方法作为参数传进来
 */
- (void)saveImageToPhotos:(UIImage*)savedImage withUrl:(NSString*)url
{
    
    [self execSavePhoto:savedImage withUrl:url];
    //使用UIKit存图方式
//    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if(error != NULL && image!=nil){
//        [self showMassage:@"图片保存失败"];
//        NSLog(@"保存失败");
//    }else{
//        [self showMassage:@"图片保存成功"];
//        NSLog(@"保存成功");
//    }
//}

-(void)saveImage:(NSString*)imagePath
{
    NSString *localIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:imagePath];
    
    UIImage *image = [self addImageViewTolocal:imagePath];
    
    if (localIdentifier == nil) {
        [self saveImageToPhotos:image withUrl:imagePath];
    }else{
        PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil].firstObject;
        if (asset == nil) {
            [self saveImageToPhotos:image withUrl:imagePath];
        }else{
            
            [_selectedPhotos addObject:image];

            [_selectedAssets addObject:asset];


        }
    }
    
}

/**

 * 调用PHPhotoLibrary库 保存图片

 */

- (void)execSavePhoto:(UIImage *)image withUrl:(NSString *)urlStr{

    if (@available(iOS 8,*)){

        __block PHAsset *phAsset = nil;
        NSMutableArray *imageId = [NSMutableArray array];
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            
            NSString *localIdentifier = req.placeholderForCreatedAsset.localIdentifier;
            [imageId addObject:localIdentifier];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageId options:nil];
            if (success) {
                [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    phAsset = obj;
                    *stop = YES;
                }];
            }
            if (phAsset != nil) {
                
                //将存在本地的图片的唯一标识符,存入plist,便于判断本地是否存在该图片
                
                //key: 表示唯一的imageUrl value: 图片的唯一标识符(localIdentifier)
                
                [[NSUserDefaults standardUserDefaults] setObject:phAsset.localIdentifier forKey:urlStr];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [_selectedPhotos addObject:image];
                
                [_selectedAssets addObject:phAsset];
                
            }
            
        }];
        

    }
}


+(void)openThirdParty:(NSString*)target{
    
    NSString *strPath = @"";
    if([target isEqualToString:@"wechat"]){
        strPath = @"weixin://";
    }
    if ([target isEqualToString:@"qq"]) {
        strPath = @"mqq://";
    }
    
    NSURL * url = [NSURL URLWithString:strPath];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen)
    {   //打开第三方app
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            // Fallback on earlier versions

        }
    }else {
        NSString *message = [NSString stringWithFormat:@"未安装%@",target];
        NSLog(@"未安装%@",target);
        [self showMassage:message];
    }
}

+(void)showMassage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

-(void)showMassage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:alertController animated:YES completion:nil];
}


@end
