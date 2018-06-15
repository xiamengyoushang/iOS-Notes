//
//  ViewController.m
//  JavascriptBridge
//
//  Created by linkiing on 2018/1/22.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UIWebView JS交互";
    } else {
        cell.textLabel.text = @"WKWebView JS交互";
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIWebViewController *webctl = [[UIWebViewController alloc] init];
        [self.navigationController pushViewController:webctl animated:YES];
    } else {
        WKWebViewController *webctl = [[WKWebViewController alloc] init];
        [self.navigationController pushViewController:webctl animated:YES];
    }
}


@end
