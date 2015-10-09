//
//  TSTabBarController.m
//  tensWebProject
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSTabBarController.h"
#import "UIView+Extension.h"
#import "SendWebView.h"


@interface TSTabBarController ()


@end

@implementation TSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setItemSelectImage];
}

-(void)setItemSelectImage
{
    [self.tabBar addSubview:self.centerButton];
    
    NSArray *selectImage = @[@"tabbar_home_selected",
                             @"tabbar_message_center_selected",
                             @"",
                             @"tabbar_discover_selected",
                             @"tabbar_profile_selected"];
    
    NSArray *viewCols = self.viewControllers;
    for (int i = 0 ; i < selectImage.count; i ++) {
        if (i == 2) {
            continue;
        }
        UIViewController *viewcol = viewCols[i];
        viewcol.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    self.tabBar.tintColor = [UIColor colorWithRed: 247/255.0 green:111/255.0 blue:0/255.0 alpha:1];
    

}

- (UIButton *)centerButton
{
    if (_centerButton == nil) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        // 获取当前试图的长和宽
        CGFloat centerX = CGRectGetMidX(self.tabBar.frame);
        /*
        CGFloat height = CGRectGetHeight(self.tabBar.frame);
        */
        _centerButton.frame = CGRectMake(centerX - 32, 2, 64, 44);
        [_centerButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_centerButton setImage: [UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        [_centerButton addTarget:self action:@selector(centerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _centerButton;
}

#pragma mark -- Action

-(void)centerButtonAction
{
    NSLog(@"点击了");
    SendWebView *view = [[SendWebView alloc]init];
    [view showView];
    
    



}




@end
