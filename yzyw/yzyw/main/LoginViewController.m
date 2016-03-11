//
//  LoginViewController.m
//  yzyw
//
//  Created by nnm on 16/2/22.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UILabel *registerlabel;

@end

@implementation LoginViewController

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
    
    
    //registerlabel点击事件
    self.registerlabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *registerlabelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerlabelTapGestureRecognizerTouchUpInside:)];
    [self.registerlabel addGestureRecognizer:registerlabelTapGestureRecognizer];
}

//registerlabel点击事件
-(void) registerlabelTapGestureRecognizerTouchUpInside:(UITapGestureRecognizer *)recognizer{
    RegisterViewController *registerviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerviewcontroller animated:YES];
}


//backimage点击事件
-(void)onClickImage{
    NSLog(@"图片被点击!");
    [self.navigationController popViewControllerAnimated:YES];
}	



@end
