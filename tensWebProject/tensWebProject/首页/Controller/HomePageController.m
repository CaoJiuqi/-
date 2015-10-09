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





@interface HomePageController ()
{
    TSPopView *popView;
}

@property(strong,nonatomic)UIView *tagView;

@property (weak, nonatomic) IBOutlet UIButton *centerText;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadData];
}

-(void)loadData
{
    
    
    
    NSString *urlstring = @"https://api.weibo.com/2/statuses/public_timeline.json";
    
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:medol.access_token forKey:@"access_token"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlstring parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        NSLog(@"---->%@",responseObject);
        NSMutableArray *array = [NSMutableArray array];
        array = responseObject[@"statuses"];
        
        NSLog(@"---------%@",array[0]);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"errror:%@",error);
    }];
    
    
    
}





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
