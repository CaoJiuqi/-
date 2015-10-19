//
//  SendWebView.m
//  tensWebProject
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SendWebView.h"
#import "UIView+Extension.h"
#import "EmoationView.h"

@interface SendWebView ()

@property (nonatomic,strong)NSMutableArray *buttonArray;
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UIButton *delectButton;

@end
@implementation SendWebView


+(instancetype)create
{

    return [[self alloc]init];
}
-(void)showView
{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.delectButton];
    [self createButton];
    

}

/**
 *  创建相应的六个按钮
 */
-(void)createButton
{
    NSArray *buttonImageName = @[@"tabbar_compose_idea",
                                 @"tabbar_compose_photo",
                                 @"tabbar_compose_camera",
                                 @"tabbar_compose_lbs",
                                 @"tabbar_compose_review",
                                 @"tabbar_compose_more"];
    
    NSArray *buttonTitle  = @[@"文字",@"相册", @"拍摄",
                              @"签到",@"点评",@"更多"];

    
    for (int i = 0; i < 6; i ++) {
//        CGFloat buttonX = 30 + (TSWedth -40)/3 * (i%3);
//        CGFloat buttonY = (TSHeight - 350) + 110 * (i/3);
        
        CGFloat buttonX = 30;
        CGFloat buttonY = TSHeight;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, 100, 110);
        button.tag = i;
        [button setImage:[UIImage imageNamed:buttonImageName[i]] forState:UIControlStateNormal];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        button.imageEdgeInsets = UIEdgeInsetsMake(-10, 10, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(90, -80, 0, 0);
        [button addTarget:self action:@selector(ClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    [self showAnmation:YES];
    
}

/**
 *  动画显示按钮
 *
 *  @param isShow 
 */

-(void)showAnmation:(BOOL)isShow
{
    CGFloat oneRow =  TSHeight - 350;
    CGFloat twoRow =  (TSHeight - 350) + 110 ;
    CGFloat delay = 0;
    
    if (!isShow) {
        oneRow =  twoRow = TSHeight;
        delay = 0.3;
    }
    for (UIButton *button in self.buttonArray) {
        
        /**
         这是UIview 封装的动画
         dampingRatio 表示反弹的效果
         
         - returns:
         */
        [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            if (isShow) {
                button.x = 30 + (TSWedth -40)/3 * (button.tag%3);
            }else
            {
                button.x = 30;
            }
            button.y = button.tag < 3 ? oneRow :twoRow ;
        } completion:^(BOOL finished) {
        }];
        
        delay = isShow ? delay + 0.05:delay - 0.05;
    }
    
}


-(UIImageView *)bgImageView
{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.frame = CGRectMake((TSWedth -250)/2.0, (TSHeight - 300)/2.0, 250, 100);

        UIImage *image = [UIImage imageNamed:@"compose_slogan"];

        self.backgroundColor = [UIColor whiteColor];
        _bgImageView.image = image;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bgImageView;
}

-(UIButton *)delectButton
{
    if (_delectButton == nil) {
        _delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _delectButton.frame = CGRectMake(0, TSHeight-50, TSWedth, 50);
        [_delectButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
        [_delectButton addTarget:self action:@selector(CloseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectButton;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}

#pragma markk -- Action
-(void)CloseAction
{

    [self showAnmation:NO];
    // 延迟移除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        
    });
    
}

-(void)ClickAction:(UIButton *)button
{

    [self buttonAnimations:button];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([self.delege respondsToSelector:@selector(OnClickDelegte:)]) {
            
            [self.delege OnClickDelegte:button.tag];
        }
    });
    
}


#pragma mark - 点击选项按钮时的动画
- (void)buttonAnimations:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        
        button.transform = CGAffineTransformMakeScale(1.5, 1.5);
        button.alpha = 0;
        
    }];
    
    
    [self.buttonArray removeObject:button];
    for (UIButton *button in self.buttonArray) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            button.transform = CGAffineTransformMakeScale(0.5, 0.5);
            button.alpha = 0;
        }];
        
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
    });
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self CloseAction];
}
@end
