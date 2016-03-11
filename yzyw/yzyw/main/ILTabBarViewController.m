//
//  ILTabBarViewController.m
//  caipiao
//
//  Created by nnm on 16/2/16.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "ILTabBarViewController.h"
#import "ILTabBar.h"

@interface ILTabBarViewController ()<ILTabBarDelegate>

@end

@implementation ILTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统自带的话，跳转有问题
    //[self.tabBar removeFromSuperview];
    
    NSLog(@"%@",self.tabBar);
    
    ILTabBar *tabBar=[[ILTabBar alloc] init];
    tabBar.frame=self.tabBar.bounds;
    
    tabBar.delegate=self;
    
    //隐藏系统自带的话，跳转有问题 替代自带的
    [self.tabBar addSubview:tabBar];
    
    
    //导航背景色 字体色
    UINavigationBar *bar=[UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"bg01"] forBarMetrics:UIBarMetricsDefault];
   
    NSDictionary *dict=@{
                         NSForegroundColorAttributeName:[UIColor whiteColor]
                         };
    [bar setTitleTextAttributes:dict];
    
    //主题颜色
    [bar setTintColor:[UIColor whiteColor]];
    
}

//delegate do
-(void)tabBar:(ILTabBar *)tabBar didSelectedIndex:(int)index
{
    self.selectedIndex=index;
}

@end
