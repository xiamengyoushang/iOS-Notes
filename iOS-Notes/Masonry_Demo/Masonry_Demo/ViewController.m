//
//  ViewController.m
//  Masonry_Demo
//
//  Created by linkiing on 2018/1/19.
//  Copyright © 2018年 linkiing. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

//Masonry-约束
- (void)Masonry_Initialize{
    /*
     //新增约束
      - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
     
     //更新约束
      - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
     
     //清除之前的所有约束,只会保留最新的约束
      - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
     */
    //防止block中的循环引用
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.center.equalTo(weakSelf.view);//相对X和Y居中显示
        //make.size.mas_equalTo(CGSizeMake(200, 200));//设置宽高
        //设置一个基于父视图间距(top, left, bottom, right)
        make.edges.mas_offset(UIEdgeInsetsMake(100, 20, 100, 20));
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Masonry使用基础
    //[self Masonry_Initialize];
    
    //Masonry设置基于父视图间距
    //[self Masonry_Offset1];
    //[self Masonry_Offset2];
    
    //Masonry设置多个子View的间距
    //[self Masonry_ViewOffset];
    
    //Masonry适配综合练习
    [self Masonry_ViewOffset_test];
}
- (void)Masonry_Offset1{
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //添加约束
        make.center.equalTo(weakSelf.view);//相对X和Y居中显示
        //设置一个基于父视图间距(top, left, bottom, right)
        //make.edges.mas_offset(UIEdgeInsetsMake(100, 20, 100, 20));
        //对top, left, bottom, right 单独设置间距
        make.top.equalTo(weakSelf.view).with.offset(100);
        make.left.equalTo(weakSelf.view).with.offset(20);
        make.bottom.equalTo(weakSelf.view).with.offset(-100);//负数
        make.right.equalTo(weakSelf.view).with.offset(-20);//负数
    }];
}
- (void)Masonry_Offset2{
    __weak typeof(self) weakSelf = self;
    UIView *bgView1 = [UIView new];
    bgView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView1];
    UIView *bgView2 = [UIView new];
    bgView2.backgroundColor = [UIColor redColor];
    [bgView1 addSubview:bgView2];
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //bgView2相对bgView1 上下左右间距为20
        //make.edges.equalTo(bgView1).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));
        //等价于
        /*
        make.top.equalTo(bgView1).with.offset(20);
        make.left.equalTo(bgView1).with.offset(20);
        make.bottom.equalTo(bgView1).with.offset(-20);
        make.right.equalTo(bgView1).with.offset(-20);
         */
        //等价于 and和with为self 什么都没做
        make.top.left.bottom.and.right.equalTo(bgView1).with.insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
}
- (void)Masonry_ViewOffset{
    __weak typeof(self) weakSelf = self;
    UIView *view1 = [UIButton new];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(weakSelf.view);
        make.top.with.offset(120);
    }];
    UIView *view2 = [UIButton new];
    view2.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(240, 240));
        make.centerX.equalTo(view1);
        //view2的顶部距离view1的底部间距为20
        make.top.equalTo(view1.mas_bottom).with.offset(20);
    }];
}
- (void)Masonry_ViewOffset_test{
    //让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10
    __weak typeof(self) weakSelf = self;
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //mas_equalTo:支持类型转换，支持复杂类型,是对equalTo的封装
        //mas_equalTo是一个具体值 equalTo可以指一个对象
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor redColor];
    [bgView addSubview:view1];
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor redColor];
    [bgView addSubview:view2];
    
    CGFloat padding = 10;
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        //make.left.equalTo(bgView.mas_left) 相当于设置左对齐
        make.left.equalTo(bgView.mas_left).with.offset(padding);
        make.right.equalTo(view2.mas_left).with.offset(-padding);
        
        //设置宽高比例 width/height = 1.0
        make.width.mas_equalTo(view1.mas_height).multipliedBy(1.0);
        
        //设置width和height mas_equalTo设置具体值 equalTo可设值可设对象
        //make.height.mas_equalTo(120);
        make.width.equalTo(view2);
        make.height.mas_equalTo(view2.mas_height);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view1.mas_centerY);
        make.right.equalTo(bgView.mas_right).with.offset(-padding);
    }];
}

@end
