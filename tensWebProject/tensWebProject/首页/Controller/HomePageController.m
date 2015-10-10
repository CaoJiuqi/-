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





@interface HomePageController ()
{
    TSPopView *popView;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic)NSMutableArray *weiboMedolArray;


@end



@implementation HomePageController


static NSString *cellID = @"TSWeiboViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TSWeiboViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self loadData];
}

/*加载数据*/
-(void)loadData
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medol.access_token forKey:@"access_token"];
    [dic setObject:@100 forKey:@"count"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:TSWeiboUrl parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        [self saveDataModelwithDictary:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"errror:%@",error);

    }];
    
    
}

#pragma mark-- 存储数据到相应的model
-(void)saveDataModelwithDictary:(NSDictionary *)dictionary
{
    NSMutableArray *modelData = dictionary[@"statuses"];
    for (NSMutableDictionary *dic in modelData) {
        WeiboMedol *model = [[WeiboMedol alloc]initWithDictary:dic];
        [self.weiboMedolArray addObject:model];
    }
    [self.tableView reloadData];
}




#pragma mark--UITableViewDataSource,UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weiboMedolArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSWeiboViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.weiboMedol = self.weiboMedolArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
