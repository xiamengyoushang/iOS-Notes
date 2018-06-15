//
//  ViewController.m
//  SDWebimage_Demo
//
//  Created by linkiing on 2018/1/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GIF.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"
#import "NSData+ImageContentType.h"

//https://github.com/rs/SDWebImage

/*
 1. 图片下载 SDWebImageDownloader
 2. 图片缓存——SDImageCache
 3. 图片加载管理器——SDWebImageManager
 4. 设置 UIImageView 的图片——UIImageView+WebCache
 */

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation ViewController

#pragma mark - Inilize
- (void)SDWebImageInitialize{
    //1.清除缓存的图像
    //[[SDWebImageManager sharedManager].imageCache clearMemory];
    //异步清除所有磁盘缓存的图像
    //[[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{}];
    
    //2.取消当前所有操作
    //[[SDWebImageManager sharedManager] cancelAll];
    //3. 最大并发数量: 6,在SDWebImageDownloader.h中有maxConcurrentDownloads这个属性
    
    //4. 缓存文件的保存名称如何处理? 我们使用:获取URL路径最后一个/后的内容 框架使用: 拿到URL路径,对该路径进行MD5加密
    
    //5. 该框架内部对内存警告的处理方式? 内部通过监听通知的方式清除缓存(在SDImageCache.m中)
    
    //6. 该框架进行缓存处理方式: 我们使用:可变字典  框架使用:NSCache
    
    //7. 如何判断图片的类型: 在判断图片类型的时候,只匹配第一个字节(根据图片格式的二进制来判断)(在NSData+ImageContentType.m中)
    
    //8. 队列中任务的处理方式: FIFO(先进先出)(在SDWebImageDownloader.h文件中定义了一个任务处理方式的枚举)
    
    //9. 如何下载图片的? 发送网络请求下载,NSURLConnection.不断拼接服务器返回给我们的数据 (在SDWebImageDownloaderOperation.m文件中 252行).
    
    //10 网络请求超时的时间? 15s (在SDWebImageDownloader.m文件中)
    
    /*
     SDWebImage核心:
     SDWebImageManager管理类: 下面有两个类(SDImageCache处理缓存的类,SDWebImageDownloader工具类,下载)
     图片下载任务在SDWebImageDownloader类下有一个SDWebImageDownloaderOperation类中处理的
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //SDWebImage基础细节
    //[self SDWebImageInitialize];
    
    //sd_setImage方法簇
    //[self sd_setImage_show];
    
    //下载图片并显示
    //[self downloadImage];
    
    //播放并显示GIF图像
    [self play_gifImage];
}
#pragma mark - sd_setImage
- (void)sd_setImage_show{
    //[_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/459653.jpg"]];
    //[_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/459653.jpg"] placeholderImage:[UIImage imageNamed:@"mrlei.png"]];
    [_imageview sd_setImageWithURL:[NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/459653.jpg"] placeholderImage:[UIImage imageNamed:@"mrlei.png"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //显示下载进度
        NSLog(@"%f",0.1 * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"下载图片");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"内存缓存");
                break;
            default:
                break;
        }
    }];
}
#pragma mark - downloadImage
- (void)downloadImage{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:@"http://imgstore.cdn.sogou.com/app/a/100540002/459653.jpg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"%f",0.1 * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _imageview.image = image;
        }];
    }];
}
#pragma mark - GIF_IMAGE
- (void)play_gifImage{
    NSURL *url = [NSURL URLWithString:@"http://e.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=3e4079778ad4b31cf0699cbfb2e60b49/c9fcc3cec3fdfc03e6e8818cd53f8794a4c22675.jpg"];
    NSData *gifData = [NSData dataWithContentsOfURL:url];
    UIImage *gifImage = [UIImage sd_animatedGIFWithData:gifData];
    _imageview.image = gifImage;
    SDImageFormat sdImageFormat = [NSData sd_imageFormatForImageData:gifData];
    switch (sdImageFormat) {
        case SDImageFormatUndefined:
            NSLog(@"图片格式-->未知");
            break;
        case SDImageFormatJPEG:
            NSLog(@"图片格式-->JPEG");
            break;
        case SDImageFormatPNG:
            NSLog(@"图片格式-->PNG");
            break;
        case SDImageFormatGIF:
            NSLog(@"图片格式-->GIF");
            break;
        case SDImageFormatTIFF:
            NSLog(@"图片格式-->TIFF");
            break;
        case SDImageFormatWebP:
            NSLog(@"图片格式-->WebP");
            break;
        case SDImageFormatHEIC:
            NSLog(@"图片格式-->HEIC");
            break;
    };
}

@end
