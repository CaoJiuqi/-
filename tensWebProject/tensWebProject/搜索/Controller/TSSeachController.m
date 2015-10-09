//
//  TSSeachController.m
//  tensWebProject
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSSeachController.h"
#import "TSSeaachFieild.h"

@interface TSSeachController ()

@property (weak, nonatomic) IBOutlet UIView *TestView;
@end

@implementation TSSeachController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTop];

}

-(void)setTop
{

    TSSeaachFieild  *seachFild = [[TSSeaachFieild alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    self.navigationItem.titleView = seachFild;

    

    
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
