//
//  WebRequestController.m
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WebRequestController.h"
#import "TSTabBarController.h"
#import "AFNetworking.h"
#import "RequestMedol.h"
#import "ArchiveModel.h"
#import "UIWindow+enterRooterConllor.h"


@interface WebRequestController () <UIWebViewDelegate>

@end

@implementation WebRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, TSWedth, TSHeight)];
    webView.backgroundColor = [UIColor lightGrayColor];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",TSAppKey,TSBackcell];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [webView loadRequest:request];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *strRequest = request.URL.relativeString;
    NSRange range = [strRequest rangeOfString:@"code="];
    if(range.location != NSNotFound)
    {
        NSString *code = [strRequest substringFromIndex:range.location +range.length ];
        [self AcssToken:code];
    
    }
    
    return  YES;
}

-(void)AcssToken:(NSString *)code
{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:TSAppKey forKey:@"client_id"];
    [parameter setValue:TSAppSecret forKey:@"client_secret"];
    [parameter setValue:@"authorization_code" forKey:@"grant_type"];
    [parameter setValue:code forKey:@"code"];
    [parameter setValue:TSBackcell forKey:@"redirect_uri"];
    
    
    
    /**
     *  POST 请求
     *  @param operation
     *  @param responseObject 返回的数据
     *  @return
     */
    [manager POST:AccTokenRequest parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        
        
        //保存Token
        RequestMedol *model = [[RequestMedol alloc]initWithDictary:responseObject];

        [ArchiveModel ArchiveModel:model];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow enterConllor];
               
        
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
