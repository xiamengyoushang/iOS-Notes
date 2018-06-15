//
//  YYWebImageExample.m
//  YYKitDemo
//
//  Created by linkiing on 2018/5/28.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "YYWebImageExample.h"
#import "YYWebImageExampleCell.h"

@interface YYWebImageExample ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *imageLinks;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation YYWebImageExample

#pragma mark - Initialize
- (void)InitializeData{
    UINib *nib = [UINib nibWithNibName:@"YYWebImageExampleCell" bundle:[NSBundle mainBundle]];
    [_tableview registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(clickReloadItem:)];
    self.navigationItem.rightBarButtonItem = button;
    
    NSArray *links = @[
                       // progressive jpeg
                       @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                       
                       // animated gif: http://cinemagraphs.com/
                       @"http://i.imgur.com/uoBwCLj.gif",
                       @"http://i.imgur.com/8KHKhxI.gif",
                       @"http://i.imgur.com/WXJaqof.gif",
                       
                       // animated gif: https://dribbble.com/markpear
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1809343/dots17.1.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1845612/dots22.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1820014/big-hero-6.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1819006/dots11.0.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1799885/dots21.gif",
                       
                       // animaged gif: https://dribbble.com/jonadinges
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/2025999/batman-beyond-the-rain.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1855350/r_nin.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1963497/way-back-home.gif",
                       @"https://d13yacurqjgara.cloudfront.net/users/288987/screenshots/1913272/depressed-slurp-cycle.gif",
                       
                       // jpg: https://dribbble.com/snootyfox
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       @"http://littlesvr.ca/apng/images/Contact.webp",
                       ];
    _imageLinks = links;
    [self.tableview reloadData];
    [self scrollViewDidScroll:self.tableview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitializeData];
}
#pragma mark - UIBarButtonItem
- (void)clickReloadItem:(UIBarButtonItem *)item{
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{}];
    [_tableview performSelector:@selector(reloadData) afterDelay:0.1];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _imageLinks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    YYWebImageExampleCell *cell = [_tableview dequeueReusableCellWithIdentifier:cellId];
    [cell setImageURL:[NSURL URLWithString:_imageLinks[indexPath.row]]];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //可视总高度
    CGFloat viewHeight = scrollView.height + scrollView.contentInset.top;
    //获取当前所显示的cell
    for (YYWebImageExampleCell *cell in [self.tableview visibleCells]) {
        CGFloat y = cell.centerY - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        if (kiOS8Later) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
                cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
            } completion:NULL];
        } else {
            cell.webImageView.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
}

@end
