//
//  WebViewController.m
//  yzyw
//
//  Created by nnm on 16/2/27.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@end

@implementation WebViewController

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
    
    self.titlelabel.text=@"关于我们";
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"webviewtype"];//根据键值取出name
    
    //backimage点击事件
    self.backimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.backimage addGestureRecognizer:singleTap];
    
    //load webview
    self.mywebview.delegate=self;
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = @"http://114.215.181.206/yzyw/WXWZ/LJWY/FL00/fuwu.aspx?TYPE=123";
    if([name isEqualToString:@"base"])
    {
        urlStr=@"http://www.kaishengnet.com/WXWZ/LJWY/FL00/baseGround2.aspx";
        self.titlelabel.text=@"基地";
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.mywebview loadRequest:request];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"erros is %@",error);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"hello");
}

//backimage点击事件
-(void)onClickImage{
    NSLog(@"图片被点击!");
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
