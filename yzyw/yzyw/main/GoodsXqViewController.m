//
//  GoodsXqViewController.m
//  yzyw
//
//  Created by nnm on 16/3/3.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "GoodsXqViewController.h"
#import "SDCycleScrollView.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginViewController.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@interface GoodsXqViewController () <SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property (weak, nonatomic) IBOutlet UIView *chooseview;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UILabel *praiselabel;
@property (weak, nonatomic) IBOutlet UIImageView *subimage;
@property (weak, nonatomic) IBOutlet UIImageView *addimage;
@property (weak, nonatomic) IBOutlet UITextField *txtsl;
@property (weak, nonatomic) IBOutlet UIImageView *buyimage;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (weak, nonatomic) IBOutlet UILabel *surpluslabel;
@end

@implementation GoodsXqViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决位置差20px，去掉状态栏算位置
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //backimage点击事件
    self.backimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.backimage addGestureRecognizer:singleTap];
    
    //buyimage点击事件
    self.buyimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *buyimagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickbuyimage)];
    [self.buyimage addGestureRecognizer:buyimagesingleTap];
    
    //subimage点击事件
    self.subimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *subimagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClicksubimage)];
    [self.subimage addGestureRecognizer:subimagesingleTap];
    
    //addimage点击事件
    self.addimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *addimagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickaddimage)];
    [self.addimage addGestureRecognizer:addimagesingleTap];
    
    //textlabel点击事件
    self.textlabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *textlabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClicktextlabel)];
    [self.textlabel addGestureRecognizer:textlabelsingleTap];

    //praiselabel点击事件
    self.praiselabel.userInteractionEnabled=YES;
    UITapGestureRecognizer *praiselabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickpraiselabel)];
    [self.praiselabel addGestureRecognizer:praiselabelsingleTap];
    
    //确定scrollView能滚动多大范围
    self.myscrollview.contentSize=CGSizeMake(0,1080);

    //将图层的边框设置为圆脚
    self.chooseview.layer.cornerRadius = 3;
    self.chooseview.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.chooseview.layer.borderWidth = 1;
    self.chooseview.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];
    
    //load webview
    self.mywebview.delegate=self;
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取NSString类型的数据
    NSString *mygoodsId = [userDefaultes stringForKey:@"mygoodsId"];
    
    NSString *postUrl = @"http://114.215.181.206/appjk/Detail.aspx?uid=admin1&goodsId=";
    
    NSString *myUrl=[postUrl stringByAppendingString:mygoodsId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{};
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
    
    //注意：此行不加也可以
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //SEND YOUR REQUEST
    [manager POST:myUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *str = [responseObject objectForKey:@"status"];
        NSArray *arr = [responseObject objectForKey:@"content"];
        NSDictionary * dict =arr[0];
        self.titlelabel.text=[dict objectForKey:@"goodsTitle"];
        self.surpluslabel.text= [NSString stringWithFormat:@"剩余：%@",[dict objectForKey:@"goodsSurplusSum"]];
        self.pricelabel.text= [NSString stringWithFormat:@"￥%@",[dict objectForKey:@"goodsPrice"]];
        
        // 情景一：采用本地图片实现
        NSString *strpic1 = [[dict objectForKey:@"LJTP"] stringByReplacingOccurrencesOfString:@"~" withString:@""];
        NSString *strpic2 = [[dict objectForKey:@"LJTP1"] stringByReplacingOccurrencesOfString:@"~" withString:@""];
        NSString *strpic3 = [[dict objectForKey:@"LJTP2"] stringByReplacingOccurrencesOfString:@"~" withString:@""];
        NSString *strpic4 = [[dict objectForKey:@"LJTP3"] stringByReplacingOccurrencesOfString:@"~" withString:@""];

        NSString *picUrl1 = [NSString stringWithFormat:@"http://114.215.181.206/yzyw%@",strpic1];
        NSString *picUrl2 = [NSString stringWithFormat:@"http://114.215.181.206/yzyw%@",strpic2];
        NSString *picUrl3 = [NSString stringWithFormat:@"http://114.215.181.206/yzyw%@",strpic3];
        NSString *picUrl4 = [NSString stringWithFormat:@"http://114.215.181.206/yzyw%@",strpic4];
        
        NSArray *imageNames = @[picUrl1,picUrl2,picUrl3,picUrl4];
        
        self.bannerView.imageURLStringsGroup = imageNames;
        self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.bannerView.delegate = self;
        self.bannerView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
        
        // 1. URL 定位资源,需要资源的地址
        NSString *urlStr = [NSString stringWithFormat:@"http://114.215.181.206/yzyw/WXWZ/LJWY/FL00/goodsDetail.aspx?GSID=%@&&TYPE=1",mygoodsId];
        NSURL *url = [NSURL URLWithString:urlStr];
        // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        // 3. 发送请求给服务器
        [self.mywebview loadRequest:request];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"erros is %@",error);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"hello");
}


//subimage点击事件
-(void)onClicksubimage{
    int sl=self.txtsl.text.intValue;
    if(sl>1)
    {
         sl--;
    }
    self.txtsl.text=[NSString stringWithFormat:@"%d",sl];
}

//addimage点击事件
-(void)onClickaddimage{
   int sl=self.txtsl.text.intValue;
   sl++;
    self.txtsl.text=[NSString stringWithFormat:@"%d",sl];
}

//buyimage点击事件
-(void)onClickbuyimage{
    LoginViewController *loginViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController: loginViewController animated:true];
}

//textlabel点击事件
-(void)onClicktextlabel{
    NSString *strColor=@"#2B9BC9";
    self.textlabel.backgroundColor=[self colorWithHexString:strColor];
    self.praiselabel.backgroundColor=[UIColor whiteColor];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取NSString类型的数据
    NSString *mygoodsId = [userDefaultes stringForKey:@"mygoodsId"];
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = [NSString stringWithFormat:@"http://114.215.181.206/yzyw/WXWZ/LJWY/FL00/goodsDetail.aspx?GSID=%@&&TYPE=1",mygoodsId];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.mywebview loadRequest:request];
}

//praiselabel点击事件
-(void)onClickpraiselabel{
    NSString *strColor=@"#2B9BC9";
    self.textlabel.backgroundColor=[UIColor whiteColor];
    self.praiselabel.backgroundColor=[self colorWithHexString:strColor];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取NSString类型的数据
    NSString *mygoodsId = [userDefaultes stringForKey:@"mygoodsId"];
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = [NSString stringWithFormat:@"http://114.215.181.206/yzyw/WXWZ/LJWY/FL00/goodsDetail.aspx?GSID=%@&&TYPE=4",mygoodsId];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.mywebview loadRequest:request];

}
//backimage点击事件
-(void)onClickImage{
    NSLog(@"图片被点击!");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)dealloc
{
    
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
