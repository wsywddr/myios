//
//  SearchViewController.m
//  yzyw
//
//  Created by nnm on 16/2/22.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UIView *view01;

@end

@implementation SearchViewController

//hide navigationbar
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决位置差20px，去掉状态栏算位置
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //backimage点击事件
    self.backimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.backimage addGestureRecognizer:singleTap];
}

//backimage点击事件
-(void)onClickImage{
    NSLog(@"图片被点击!");
    [self.navigationController popToRootViewControllerAnimated:YES];  
}

@end
