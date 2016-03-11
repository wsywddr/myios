//
//  GoodsTypeViewController.m
//  yzyw
//
//  Created by nnm on 16/2/25.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "GoodsTypeViewController.h"
#import "HMTg.h"
#import "HMTgCell.h"
#import "GoodsListViewController.h"

@interface GoodsTypeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (weak, nonatomic) IBOutlet UIImageView *backimage;

@property (nonatomic, strong) NSArray *tgs;
@end

@implementation GoodsTypeViewController

- (NSArray *)tgs
{
    if (_tgs == nil) _tgs = [HMTg tgs];
    return _tgs;
}

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
    
    // 指定表格的数据源
    self.mytableview.dataSource=self;
    self.mytableview.delegate=self;
    
    // 调整边距，可以让表格视图让开状态栏
    self.mytableview.rowHeight = 80;
    
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

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 可重用标示符
    static NSString *ID = @"Cell";
    // 2. tableView查询可重用Cell
    HMTgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3. 如果没有可重用cell
    if (cell == nil) {
        // 从XIB加载自定义视图
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HMTgCell" owner:nil options:nil] lastObject];
        NSLog(@"可重用cell");
    }
    
    //select无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 4. 设置Cell内容
    // 1> 取出模型
    HMTg *tg = self.tgs[indexPath.row];
    cell.onetitle.text = tg.title;
    cell.iconimage.image = [UIImage imageNamed:tg.icon];
    cell.secontitle.text = tg.sectitle;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %@",__func__,indexPath);
   //[tableView deselectRowAtIndexPath:indexPath animated:YES];  //select无色消失动画
    
    GoodsListViewController *goodlistViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GoodsListViewController"];
    [self.navigationController pushViewController: goodlistViewController animated:true];
}
@end
