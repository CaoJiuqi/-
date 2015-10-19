//
//  FirendsListViewController.m
//  tensWebProject
//
//  Created by tens on 15-10-16.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "FirendsListViewController.h"
#import "FirendsCell.h"
#import "TSNavgationController.h"
#import "TSSeaachFieild.h"
#import "AFHRequestHttp.h"
#import "RequestMedol.h"
#import "ArchiveModel.h"
#import "UserMedol.h"
#import "NSString+ToPinyin.h"


@interface FirendsListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *firendsTableView;
@property (strong,nonatomic)TSSeaachFieild *searchView;


@property (nonatomic,strong)NSMutableArray *allfriendsArray;

@property (nonatomic,strong)NSMutableArray *firendsImageUrlArray;



@end

@implementation FirendsListViewController

-(NSMutableArray *)allfriendsArray
{
    if (! _allfriendsArray) {
        _allfriendsArray = [[NSMutableArray alloc]init];
    }
    return _allfriendsArray;
}
-(NSMutableArray *)friendsImageUrlArray
{
    if (_firendsImageUrlArray == nil) {
        _firendsImageUrlArray = [[NSMutableArray alloc]init];
    }
    
    return _firendsImageUrlArray;
}


-(void)viewDidLoad
{
    [super viewDidLoad];

    
    [self loadFriendsData];
    [self createSearchView];
    
    
    
}

-(void)createSearchView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
    view.backgroundColor = [UIColor lightGrayColor];
    self.searchView = [[TSSeaachFieild alloc]initWithFrame:CGRectMake(20, 10, TSWedth - 40, 35)];
    self.searchView.backgroundColor = [UIColor grayColor];
    [view addSubview:self.searchView];
    self.firendsTableView.tableHeaderView = view;
}


-(void)loadFriendsData
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *parames = [[NSMutableDictionary alloc]init];
    [parames setObject:medol.access_token forKey:@"access_token"];
    [parames setObject:medol.uid forKey:@"uid"];
    
    
    [AFHRequestHttp requestURL:TSrequestUrl parameters:parames requestType:RequestISGET success:^(id result) {
        // 返回的数据是字典
        [self saveFirendsData:result];
        
    } failure:^(id error) {
        NSLog(@"error:%@",error);
    }];
    
    
    
}

#pragma mark-- 解析返回的数据
-(void)saveFirendsData:(id)result
{

    NSArray *userArray = result[@"users"];
    for (NSMutableDictionary *dic in userArray) {
        UserMedol *medol = [[UserMedol alloc]initWithDictary:dic];
        
        NSLog(@"--->%@",medol.screen_name);
        medol.pinyin = [medol.screen_name toPinyin];
        medol.firstChar = [medol.pinyin substringWithRange:NSMakeRange(0, 1)];
        
        [self.allfriendsArray addObject:medol];
        
    }

//    NSLog(@"userarray :%@",userArray);
    
    NSLog(@"---->%ld",self.allfriendsArray.count);
    
}


#pragma mark--<UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    FirendsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirendsCell" forIndexPath:indexPath];
//    NSLog(@"  =====%ld",self.allfriendsArray.count);
    
    
    cell.medol = self.allfriendsArray[indexPath.row];
    
    return cell;
}


@end
