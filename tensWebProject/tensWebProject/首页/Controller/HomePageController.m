//
//  HomePageController.m
//  tensWebProject
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "HomePageController.h"
#import "TSPopView.h"
#import "AFNetworking.h"
#import "ArchiveModel.h"
#import "RequestMedol.h"
#import "TSWeiboViewCell.h"
#import "WeiboMedol.h"
#import "TSWeiboViewCell.h"
#import "MJRefresh.h"
#import "TSWeiboDetailViewController.h"
#import "AFHRequestHttp.h"




@interface HomePageController () <UITableViewDataSource,UITableViewDelegate>
{
    TSPopView *popView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *weiboMedolArray;

@end

@implementation HomePageController


static NSString *cellID = @"WeiboViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:TSSendWeiboSuccessNotification object:nil];
    // 添加下拉视图
    [self addHeaderRefreshView];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TSWeiboViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark -- 上拉 、 下拉 加载数据视图
- (void)addHeaderRefreshView
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.header beginRefreshing];
}

- (void)addFooterDataView
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addRefreshfooterData)];
}

#pragma mark-- 添加下拉视图、及触发的方法
/*加载数据*/

- (void)loadData
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medol.access_token forKey:@"access_token"];

    WeiboMedol *weibomodel =[self.weiboMedolArray firstObject ];
    if (weibomodel) {
        [dic setObject:weibomodel.idstr forKey:@"since_id" ];
    }
    
    //发送请求
    [AFHRequestHttp requestURL:TSWeiboUrl parameters:dic requestType:RequestISGET success:^(id result) {
        
        [self saveDataModelwithDictary:result];
    } failure:^(id error) {
        
        NSLog(@"errror:%@",error);
        [self.tableView.header endRefreshing];
    }];
    
}

#pragma mark-- 存储数据到相应的model
-(void)saveDataModelwithDictary:(NSDictionary *)dictionary
{
    NSMutableArray *newweiboModelArray = [[NSMutableArray alloc]init];
    NSMutableArray *modelData = dictionary[@"statuses"];
    
    for (NSDictionary *dic in modelData) {
        WeiboMedol *model = [[WeiboMedol alloc]initWithDictary:dic];
        [newweiboModelArray addObject:model];
    }
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newweiboModelArray.count)];
    [self.weiboMedolArray insertObjects:newweiboModelArray atIndexes:set];
    
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    
    if (self.tableView.footer == nil) {
        [self addFooterDataView];
    }
    
}


#pragma mark--添加上拉视图 、及触发的方法

-(void)addRefreshfooterData
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medol.access_token forKey:@"access_token"];
    WeiboMedol *weibomodel =[self.weiboMedolArray lastObject ];
    if (weibomodel) {
        
        NSString *maxid = [NSString stringWithFormat:@"%lld",[weibomodel.idstr  longLongValue] - 1];
        [dic setObject:maxid forKey:@"max_id" ];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:TSWeiboUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self loadfooterDataModelwithDictary:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"errror:%@",error);
        [self.tableView.footer endRefreshing];
    }];
}

-(void)loadfooterDataModelwithDictary:(NSDictionary *)dictionary
{
    NSMutableArray *modelData = dictionary[@"statuses"];
    for (NSMutableDictionary *dic in modelData) {
        WeiboMedol *model = [[WeiboMedol alloc]initWithDictary:dic];
        [self.weiboMedolArray addObject:model];
    }
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

#pragma mark--UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboMedolArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSWeiboViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.weiboMedol = self.weiboMedolArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了");
//    TSWeiboDetailViewController *detailCV = [self.storyboard instantiateViewControllerWithIdentifier:@"TSWeiboDetailViewController"];
//    detailCV.medol = self.weiboMedolArray[indexPath.row];
//    [self.navigationController pushViewController:detailCV animated:YES];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboMedol *medol = self.weiboMedolArray[indexPath.row];
    return [TSWeiboViewCell showrangHeight:medol];
}

/*创建PopularView*/
-(void)createPopView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor lightGrayColor];
    popView = [[TSPopView alloc]init];
    popView.contentView = view;
}

- (IBAction)ButtonAction:(UIButton *)sender {
    
    [self createPopView];
    [popView showPopView:sender WithType:PopViewCenter];
    
}

#pragma mark-- 初始化数据
-(NSMutableArray *)weiboMedolArray
{
    if (_weiboMedolArray == nil) {
        _weiboMedolArray = [[NSMutableArray alloc]init];
    }
    return _weiboMedolArray;
}


#pragma mark -- Action

- (IBAction)ActionLeft:(id)sender {
    [self createPopView];
    [popView showPopView:sender WithType:PopViewLeft];

}

- (IBAction)ReightAction:(id)sender {
    [self createPopView];
    [popView showPopView:sender WithType:PopViewRight];

}





@end
