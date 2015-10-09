//
//  WelComeViewController.m
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WelComeViewController.h"

@interface WelComeViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageView;
@property (weak, nonatomic) IBOutlet UIButton *enterMainButton;

@end

@implementation WelComeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadImage];
    
    

}

-(void)loadImage
{
    self.scrollView.contentSize = CGSizeMake(TSWedth * 4, TSHeight);
    for (int i = 0; i <  4 ; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(TSWedth * i , 0, TSWedth, TSHeight)];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/TSWedth;
    self.pageView.currentPage = currentPage;
    if (currentPage == 3) {
        self.enterMainButton.hidden = NO;
    }
    else
    {
        self.enterMainButton.hidden = YES;
    }

}

- (IBAction)enterManController:(UIButton *)sender {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    window.rootViewController = [storyboard instantiateInitialViewController];
    
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
