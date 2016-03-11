//
//  VipViewController.m
//  yzyw
//
//  Created by nnm on 16/2/21.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "VipViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@interface VipViewController ()
@property (weak, nonatomic) IBOutlet UIView *msgView;
@property (weak, nonatomic) IBOutlet UILabel *loginlabel;
@property (weak, nonatomic) IBOutlet UILabel *registerlabel;

@end

@implementation VipViewController

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
    
    //添加边框和提示
    self.msgView.layer.borderWidth = 2;
    NSString *strColor=@"#F3F3F3";
    UIColor *color1=[self colorWithHexString:strColor];
    self.msgView.layer.borderColor = [color1 CGColor];
    
    
    //loginlabel点击事件
    self.loginlabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *loginlabelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginlabelTouchUpInside:)];
    [self.loginlabel addGestureRecognizer:loginlabelTapGestureRecognizer];
    
    //registerlabel点击事件
    self.registerlabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *registerlabelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerlabelTouchUpInside:)];
    [self.registerlabel addGestureRecognizer:registerlabelTapGestureRecognizer];
}

//loginlabel点击事件
-(void) loginlabelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    LoginViewController *loginviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginviewcontroller animated:YES];
}

//registerlabel点击事件
-(void) registerlabelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    RegisterViewController *registerviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerviewcontroller animated:YES];
}


//字符串转颜色
- (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



@end
