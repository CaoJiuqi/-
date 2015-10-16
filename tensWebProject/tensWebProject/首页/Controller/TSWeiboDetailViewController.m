//
//  TSWeiboDetailViewController.m
//  tensWebProject
//
//  Created by tens on 15-10-13.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSWeiboDetailViewController.h"
#import "TSWeiboViewCell.h"
#import "WeiboDetailCell.h"
#import "ArchiveModel.h"
#import "RequestMedol.h"
#import "AFNetworking.h"
#import "AFHRequestHttp.h"


@interface TSWeiboDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *commentableView;

@property (nonatomic,strong)NSMutableArray *commentsMedolArray;

@end

static NSString *commentCellID = @"WeiboDetailCell";
static NSString *weiboCewllID = @"WeiboViewCell";

@implementation TSWeiboDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title  = @"微博详情";
    
     [self.commentableView registerNib:[UINib nibWithNibName:@"TSWeiboViewCell" bundle: nil] forCellReuseIdentifier:weiboCewllID];
    
    [self loadWeiBoDetailData];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMedol:(WeiboMedol *)medol
{
    _medol = medol;


    
}
-(NSMutableArray *)commentsMedolArray
{
    if (_commentsMedolArray == nil) {
        _commentsMedolArray = [[NSMutableArray alloc]init];
    }
    return _commentsMedolArray;
}


#pragma mark --   获取微博信息详情
-(void)loadWeiBoDetailData
{
    
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medol.access_token forKey:@"access_token"];
    [dic setObject:self.medol.idstr forKey:@"id"];
    
    
    NSLog(@"access_token:%@",medol.access_token);
    NSLog(@"self.medol.idstr:   %@",self.medol.idstr);
    

   [AFHRequestHttp requestURL:TSWeiBoDetailUrl parameters:dic requestType:RequestISGET success:^(id result) {
       NSLog(@"请求成功");
              [self saveDataModelwithDictary:result];

    } failure:^(id error) {
                NSLog(@"error :%@",error);
    }];
    

    
    
}

#pragma mark-- 存储数据到相应的model
-(void)saveDataModelwithDictary:(NSDictionary *)dictionary
{
    NSArray *comments = dictionary[@"comments"];
    
    for (NSDictionary *commentDic in comments) {
        WeiboDetailMedol *model = [[WeiboDetailMedol alloc]initWithDictary:commentDic];
        [self.commentsMedolArray addObject:model];
    }
    
    [self.commentableView reloadData];
    
    
}




#pragma mark --UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"========%@",self.commentsMedolArray);
    if (section == 0)
    {
        return 1;
    }
    
    NSLog(@"count :%ld",self.commentsMedolArray.count);
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        

        TSWeiboViewCell *cell = [tableView dequeueReusableCellWithIdentifier:weiboCewllID forIndexPath:indexPath];
        

        cell.weiboMedol = self.medol;
        return cell;
    }

    
    WeiboDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID forIndexPath:indexPath];

    cell.medol = self.commentsMedolArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 20;
    }
    
    return 50;
}




@end
