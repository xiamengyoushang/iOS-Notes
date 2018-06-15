//
//  ViewController.m
//  AFNetworking_Demo
//
//  Created by linkiing on 2018/1/18.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

//导入外部文件时选择Creat groups否则compile sources里无编译文件
//plist添加App Transport Security Settings
//https://github.com/AFNetworking/AFNetworking

#define DOUBAN_BOOK_SEARCH @"https://api.douban.com/v2/book/search"
#define DOWNLOAD_TASK_URL  @"http://app-upd.oss-cn-shenzhen.aliyuncs.com/BLE_OTA/Dot-Matrix/DM1664-standard/shoes/DM1664-standard-2640-IA-V3.07-20180117.bin"

/*
 网络通信模块(NSURLSession)
 网络状态监听模块(Reachability)
 网络通信安全策略模块(Security)
 网络通信信息序列化/反序列化模块(Serialization)
 对于iOS UIKit库的扩展(UIKit)
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //HTTP GET请求
    //[self GET_HTTP_DATA];
    
    //HTTP POST请求
    //[self POST_HTTP_DATA];
    
    //获取沙盒路径
    //[self SANDBOX_PATH];
    
    //HTTP 下载任务
    [self DOWNLOAD_TASK];
    
    //HTTP 上传任务
    //[self UPLOAD_TASK];
    
    //网络状态监测
    [self AFNetworkStatus];
}
#pragma mark - GET
- (void)GET_HTTP_DATA{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString=[NSString stringWithFormat:@"%@%@",DOUBAN_BOOK_SEARCH,@"?q=少女"];
    NSLog(@"%@",urlString);
    //转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * responsedic = (NSDictionary*)responseObject;
        NSLog(@"GET请求成功-->%@",responsedic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET请求失败-->%@",error);
    }];
}
#pragma mark - POST
- (void)POST_HTTP_DATA{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求参数
    NSMutableDictionary *paramsdic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"少女",@"q", nil];
    NSString *urlString= DOUBAN_BOOK_SEARCH;
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlString parameters:paramsdic progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POST请求成功");
        NSDictionary * responsedic = (NSDictionary*)responseObject;
        NSArray * booksArray = [responsedic valueForKey:@"books"];
        for (NSInteger i=0; i<booksArray.count; i++) {
            NSDictionary *bookdic = [booksArray objectAtIndex:i];
            NSLog(@"%lu-->%ld,%@",(unsigned long)booksArray.count,i+1,[bookdic objectForKey:@"alt_title"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST请求失败-->%@",error);
    }];
}
#pragma mark - Sandbox
- (void)SANDBOX_PATH{
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"沙盒主目录路径-->%@",homeDir);
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"获取Documents目录路径-->%@",docDir);
    NSString *libDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"获取Library的目录路径-->%@",libDir);
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"获取Caches目录路径-->%@",cachesDir);
    NSString *tmpDir =  NSTemporaryDirectory();
    NSLog(@"获取tmp目录路径-->%@",tmpDir);
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
    //NSLog(@"获取应用程序程序包中资源文件路径-->%@",imagePath);
}
#pragma mark - DOWNLOAD
- (void)DOWNLOAD_TASK{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString= DOWNLOAD_TASK_URL;
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *requestUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"下载完成-->%@,%@",response,filePath);
    }];
    //开启任务
    [task resume];
}
#pragma mark - UPLOAD
- (void)UPLOAD_TASK{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //上传文件参数
    NSDictionary *uploadDic = [NSDictionary dictionaryWithObjectsAndKeys:@"mr.lei",@"username", nil];
    NSString *urlString= @"";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlString parameters:uploadDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件
        UIImage *iamge = [UIImage imageNamed:@"lei.png"];
        NSData *data = UIImagePNGRepresentation(iamge);
        [formData appendPartWithFileData:data name:@"file" fileName:@"lei.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lf",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功-->%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败-->%@",error);
    }];
}
#pragma mark - NetworkStatus
- (void)AFNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }];
}

@end
