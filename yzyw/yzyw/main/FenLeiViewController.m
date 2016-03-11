//
//  FenLeiViewController.m
//  yzyw
//
//  Created by nnm on 16/2/20.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "FenLeiViewController.h"
#import "SDCycleScrollView.h"

@interface FenLeiViewController () <SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *bannerView;

@end

@implementation FenLeiViewController

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
    
    
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"image1.jpg",
                            @"image2.jpg",
                            @"image3.jpg",
                            @"image4.jpg"// 本地图片请填写全名
                            ];
    
    self.bannerView.imageURLStringsGroup = imageNames;
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.delegate = self;
    self.bannerView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

- (void)dealloc
{
    
}


@end
