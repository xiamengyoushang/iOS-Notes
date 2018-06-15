//
//  ViewController.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/25.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

#pragma mark - YYKit
- (void)YYKit_Inilitialize{
    /**
     https://github.com/ibireme/YYKit
     为 NSObject+YYAddForARC.m 和 NSThread+YYAdd.m 添加编译参数 -fno-objc-arc。
     链接以下 frameworks:
     UIKit
     CoreFoundation
     CoreText
     CoreGraphics
     CoreImage
     QuartzCore
     ImageIO
     AssetsLibrary
     Accelerate
     MobileCoreServices
     SystemConfiguration
     sqlite3
     libz
     如果你需要支持 WebP，可以将 Vendor/WebP.framework(静态库) 加入你的工程。
     **/
    /**
     YYModel — 高性能的 iOS JSON 模型框架。
     YYCache — 高性能的 iOS 缓存框架。
     YYImage — 功能强大的 iOS 图像框架。
     YYWebImage — 高性能的 iOS 异步图像加载框架。
     YYText — 功能强大的 iOS 富文本框架。
     YYKeyboardManager — iOS 键盘监听管理工具。
     YYDispatchQueuePool — iOS 全局并发队列管理工具。
     YYAsyncLayer — iOS 异步绘制与显示的工具。
     YYCategories — 功能丰富的 Category 类型工具库。
     **/
    self.title = @"YYKit Example";
    _titles = [[NSMutableArray alloc] initWithCapacity:0];
    _classNames = [[NSMutableArray alloc] initWithCapacity:0];
    [self addCell:@"Model" class:@"YYModelExample"];
    [self addCell:@"Image" class:@"YYImageExample"];
    [self addCell:@"Text" class:@"YYTextExample"];
    [self addCell:@"Feed List Demo" class:@"YYFeedListExample"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self YYKit_Inilitialize];
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [_tableview deselectRowAtIndexPath:indexPath animated:YES];
}

@end



