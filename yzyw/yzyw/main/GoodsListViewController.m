//
//  GoodsListViewController.m
//  yzyw
//
//  Created by nnm on 16/2/27.
//  Copyright © 2016年 nnm. All rights reserved.
//

#import "GoodsListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GDLtCell.h"
#import "UIImageView+WebCache.h"
#import "GoodsXqViewController.h"
#import "MJRefresh.h"

@interface GoodsListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (weak, nonatomic) IBOutlet UIImageView *backimage;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UIView *searchview;
@property int pageindex;
//保存数据列表
@property(nonatomic,strong) NSMutableArray * listData;
@end

@implementation GoodsListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //解决位置差20px，去掉状态栏算位置
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.listData = [[NSMutableArray alloc] init];
    
    self.titlelable.text=@"所有商品";
    
    self.pageindex=1;
    
    //将图层的边框设置为圆脚
    self.searchview.layer.cornerRadius = 5;
    self.searchview.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    self.searchview.layer.borderWidth = 1;
    self.searchview.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] CGColor];
    
    //backimage点击事件
    self.backimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.backimage addGestureRecognizer:singleTap];
    
    // 指定表格的数据源
    self.mytableview.dataSource=self;
    self.mytableview.delegate=self;
    
    // 调整边距，可以让表格视图让开状态栏
    self.mytableview.rowHeight = 80;
    
    [self setupRefresh];
    
    [self headerRereshing];
}
- (void)setupRefresh
{
    [self.mytableview addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.mytableview addFooterWithTarget:self action:@selector(footerRereshing)];
    
    self.mytableview.headerPullToRefreshText=@"下拉可以刷新";
    self.mytableview.headerRefreshingText=@"正在刷新中...";
    self.mytableview.headerReleaseToRefreshText=@"松开立即刷新";
    
    self.mytableview.footerPullToRefreshText = @"上拉加载更多";
    self.mytableview.footerReleaseToRefreshText = @"松开马上加载";
    self.mytableview.footerRefreshingText = @"正在加载中...";
}

-(void)headerRereshing
{
    NSString *postUrl = @"http://139.196.166.58/appjk/fenlei.aspx?productOccasion=1&value=&type=1&pageIndex=1&classify=";
    
    NSDictionary *parameters = @{@"name": @"1",
                                 @"pasw": @"2"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
    
    //注意：此行不加也可以
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    //SEND YOUR REQUEST
    [manager POST:postUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSString *str = [responseObject objectForKey:@"status"];
        NSLog(@"NSString: %@", str);
        self.listData = [responseObject objectForKey:@"content"];
        [self.mytableview reloadData];   //刷新数据
        [self.mytableview headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageindex+=1;
        NSString *postUrl =[NSString stringWithFormat:@"http://139.196.166.58/appjk/fenlei.aspx?productOccasion=1&value=&type=1&pageIndex=%d&classify=",self.pageindex];
        
        NSDictionary *parameters = @{@"name": @"1",
                                     @"pasw": @"2"};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
        
        //注意：此行不加也可以
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
        
        //SEND YOUR REQUEST
        [manager POST:postUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //        NSLog(@"JSON: %@", responseObject);
            
            NSString *str = [responseObject objectForKey:@"status"];
            if([str isEqualToString:@"0000"])
            {
                NSArray *arr = [responseObject objectForKey:@"content"];
                
                NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
                [mutaArray addObjectsFromArray:self.listData];
                [mutaArray addObjectsFromArray:arr];
                
                self.listData = mutaArray;
                
                [self.mytableview reloadData];   //刷新数据
            }else{
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.mytableview footerEndRefreshing];
    });
}

//backimage点击事件
-(void)onClickImage{
    NSLog(@"图片被点击!");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 可重用标示符
    static NSString *ID = @"GDLtCell";
    // 2. tableView查询可重用Cell
    GDLtCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3. 如果没有可重用cell
    if (cell == nil) {
        // 从XIB加载自定义视图
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GDLtCell" owner:nil options:nil] lastObject];
        NSLog(@"可重用cell");
    }
    
    //select无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 4. 设置Cell内容
    NSMutableDictionary * dict = self.listData[indexPath.row];
    cell.mytitle.text = [dict objectForKey:@"goodsTitle"];
    
    NSString *imgUrl=[NSString stringWithFormat:@"http://114.215.181.206/yzyw/%@",[dict objectForKey:@"goodsImageId"]];
    NSURL* imagePath1 = [NSURL URLWithString:imgUrl];
    //图片缓存的基本代码，就是这么简单
    [cell.myimage sd_setImageWithURL:imagePath1];
    
    cell.myprice.text = [dict objectForKey:@"goodsPrice"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %@",__func__,indexPath);
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];  //select无色消失动画
    
    NSMutableDictionary * dict = self.listData[indexPath.row];
    NSString *myString = [dict objectForKey:@"id"];
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:myString forKey:@"mygoodsId"];
    
    GoodsXqViewController *goodsxqViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"GoodsXqViewController"];
    [self.navigationController pushViewController: goodsxqViewController animated:true];
}
@end
