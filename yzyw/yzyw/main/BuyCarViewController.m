//
//  BuyCarViewController.m
//  yzyw
//
//  Created by nnm on 16/2/20.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "BuyCarViewController.h"
#import "LoginViewController.h"

@interface BuyCarViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@end

@implementation BuyCarViewController

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
    
    [self.loginbtn addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goToLogin
{
    LoginViewController *loginviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginviewcontroller animated:YES];
}

@end
