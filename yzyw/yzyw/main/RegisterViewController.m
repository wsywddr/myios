//
//  RegisterViewController.m
//  yzyw
//
//  Created by nnm on 16/2/22.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backimage;

@end

@implementation RegisterViewController

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
    
    //返回根
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    //调到第几层
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]
//                                          animated:YES];
    
    
    //返回上一层
    [self.navigationController popViewControllerAnimated:YES];
}


@end
