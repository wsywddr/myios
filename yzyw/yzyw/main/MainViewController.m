//
//  MainViewController.m
//  yzyw
//
//  Created by nnm on 16/2/17.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "SearchViewController.h"
#import "GoodsTypeViewController.h"
#import "WebViewController.h"
#import "GoodsListViewController.h"

@interface MainViewController () <SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;
@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UIView *allImage;
@property (weak, nonatomic) IBOutlet UILabel *alllabel;

@property (weak, nonatomic) IBOutlet UIView *baseImage;
@property (weak, nonatomic) IBOutlet UILabel *baselabel;

@property (weak, nonatomic) IBOutlet UIView *aboutImage;
@property (weak, nonatomic) IBOutlet UILabel *aboutlabel;

@property (weak, nonatomic) IBOutlet UILabel *viplabel;
@property (weak, nonatomic) IBOutlet UIView *vipImage;

@property (weak, nonatomic) IBOutlet UIView *candiImage;
@property (weak, nonatomic) IBOutlet UILabel *candilabel;

@property (weak, nonatomic) IBOutlet UIView *zhuisuImage;
@property (weak, nonatomic) IBOutlet UILabel *zhuisulabel;

@property (weak, nonatomic) IBOutlet UIView *baozhuangImage;
@property (weak, nonatomic) IBOutlet UILabel *baozhuanglabel;

@property (weak, nonatomic) IBOutlet UIView *changheImage;
@property (weak, nonatomic) IBOutlet UILabel *changhelabel;

@property (weak, nonatomic) IBOutlet UIImageView *yushouImage;
@property (weak, nonatomic) IBOutlet UIImageView *xinpinImage;
@property (weak, nonatomic) IBOutlet UIImageView *meizhouImage;
@property (weak, nonatomic) IBOutlet UIImageView *qianggouImage;

@end

@implementation MainViewController

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
    
    //确定scrollView能滚动多大范围
    self.myscrollview.contentSize=CGSizeMake(0,840);

    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"gundong001.jpg",
                            @"gundong002.jpg",
                            @"gundong003.jpg",
                            @"gundong004.jpg"// 本地图片请填写全名
                            ];
    
    self.bannerView.imageURLStringsGroup = imageNames;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.delegate = self;
    self.bannerView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    
    
    //searchview点击事件
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.searchView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    
    
    //allImage点击事件
    UITapGestureRecognizer *allImagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allImageclick:)];
    [self.allImage addGestureRecognizer:allImagesingleTap];
    allImagesingleTap.delegate = self;
    allImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *alllabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allImageclick:)];
    self.alllabel.userInteractionEnabled=YES;
    [self.alllabel addGestureRecognizer:alllabelsingleTap];
    
    //baseImage点击事件
    UITapGestureRecognizer* baseImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(baseImageclick:)];
    [self.baseImage addGestureRecognizer:baseImagesingleTap];
    baseImagesingleTap.delegate = self;
    baseImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *baselabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baseImageclick:)];
    self.baselabel.userInteractionEnabled=YES;
    [self.baselabel addGestureRecognizer:baselabelsingleTap];
    
    //aboutImage点击事件
    UITapGestureRecognizer* aboutImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutImageclick:)];
    [self.aboutImage addGestureRecognizer:aboutImagesingleTap];
    aboutImagesingleTap.delegate = self;
    aboutImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *aboutlabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aboutImageclick:)];
    self.aboutlabel.userInteractionEnabled=YES;
    [self.aboutlabel addGestureRecognizer:aboutlabelsingleTap];
    
    //vipImage点击事件
    UITapGestureRecognizer* vipImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vipImageclick:)];
    [self.vipImage addGestureRecognizer:vipImagesingleTap];
    vipImagesingleTap.delegate = self;
    vipImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *viplabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vipImageclick:)];
    self.viplabel.userInteractionEnabled=YES;
    [self.viplabel addGestureRecognizer:viplabelsingleTap];
    
    //candiImage点击事件
    UITapGestureRecognizer* candiImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(candiImageclick:)];
    [self.candiImage addGestureRecognizer:candiImagesingleTap];
    candiImagesingleTap.delegate = self;
    candiImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *candilabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(candiImageclick:)];
    self.candilabel.userInteractionEnabled=YES;
    [self.candilabel addGestureRecognizer:candilabelsingleTap];
    
    //baozhuangImage点击事件
    UITapGestureRecognizer* baozhuangImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(candiImageclick:)];
    [self.baozhuangImage addGestureRecognizer:baozhuangImagesingleTap];
    baozhuangImagesingleTap.delegate = self;
    baozhuangImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *baozhuanglabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(candiImageclick:)];
    self.baozhuanglabel.userInteractionEnabled=YES;
    [self.baozhuanglabel addGestureRecognizer:baozhuanglabelsingleTap];
    
    //changheImage点击事件
    UITapGestureRecognizer* changheImagesingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(candiImageclick:)];
    [self.changheImage addGestureRecognizer:changheImagesingleTap];
    changheImagesingleTap.delegate = self;
    changheImagesingleTap.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *changhelabelsingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(candiImageclick:)];
    self.changhelabel.userInteractionEnabled=YES;
    [self.changhelabel addGestureRecognizer:changhelabelsingleTap];
    
    //yushouImage点击事件
    self.yushouImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *yushouImagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickyushouImage)];
    [self.yushouImage addGestureRecognizer:yushouImagesingleTap];
    
    //xinpinImage点击事件
    self.xinpinImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *xinpinImagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickyushouImage)];
    [self.xinpinImage addGestureRecognizer:xinpinImagesingleTap];
    
    //meizhouImage点击事件
    self.meizhouImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *meizhouImagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickyushouImage)];
    [self.meizhouImage addGestureRecognizer:meizhouImagesingleTap];
    
    //qianggouImage点击事件
    self.qianggouImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *qianggouImagesingleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickyushouImage)];
    [self.qianggouImage addGestureRecognizer:qianggouImagesingleTap];
}

//yushouImage xinpinImage meizhouImage qianggouImage点击事件
-(void)onClickyushouImage{
    GoodsListViewController *allgoodViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GoodsListViewController"];
    [self.navigationController pushViewController: allgoodViewController animated:true];
}

//searchview点击事件
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
   SearchViewController *searchViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    
    [self.navigationController pushViewController: searchViewController animated:true];
}

//allImage点击事件
-(void)allImageclick:(UITapGestureRecognizer *)sender{
    GoodsTypeViewController *allgoodViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GoodsTypeViewController"];
    [self.navigationController pushViewController: allgoodViewController animated:true];
}

//candiImage baozhuangImage changheImage点击事件
-(void)candiImageclick:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    GoodsListViewController *allgoodViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GoodsListViewController"];
    [self.navigationController pushViewController: allgoodViewController animated:true];
}

//baseImage点击事件
-(void)baseImageclick:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name =@"base";
    [defaults setObject:name forKey:@"webviewtype"];
    
    WebViewController *webviewViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [self.navigationController pushViewController: webviewViewController animated:true];
}

//aboutImage点击事件
-(void)aboutImageclick:(UITapGestureRecognizer *)sender{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name =@"about";
    [defaults setObject:name forKey:@"webviewtype"];
    
    WebViewController *webviewViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [self.navigationController pushViewController: webviewViewController animated:true];
}

//vipImage点击事件
-(void)vipImageclick:(UITapGestureRecognizer *)sender{

}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)dealloc
{
    
}


@end
