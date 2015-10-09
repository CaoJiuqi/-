//
//  TSPopView.m
//  tensWebProject
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSPopView.h"
#import "UIView+Extension.h"

@interface TSPopView()

@property (nonatomic,strong)UIImageView *popView;

@end
@implementation TSPopView

-(UIView *)popView
{
    if (_popView ==nil) {
        _popView = [[UIImageView alloc]init];
        // 设置为首相相应
        _popView.userInteractionEnabled = YES;
       
        [self addSubview:_popView];
    }
    
    return _popView;
}

-(void)showPopView:(UIView *)view WithType:(PopViewType)type
{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    keyWindow.backgroundColor = [UIColor lightGrayColor];
    self.frame = keyWindow.bounds;
    [keyWindow addSubview:self];
  
    CGRect newFream = [view convertRect:view.bounds toView:keyWindow];

    NSString *imageName = nil;
    if (type == PopViewLeft) {
        imageName = @"popover_background_left";
        self.popView.x = CGRectGetMinX(newFream);

        
    }else if(type == PopViewCenter)
    {
        imageName = @"popover_background";
        self.popView.centerX = CGRectGetMidX(newFream);

    }else if(type ==PopViewRight)
    {
    
        imageName = @"popover_background_right";
        self.popView.x = CGRectGetMaxX(newFream)-CGRectGetWidth(self.popView.frame);

    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:50 topCapHeight:20];
    _popView.image = image;
    
    // 这是将不同参考系的位置的获取的转换
    
    self.popView.y = CGRectGetMaxY(newFream);

    

    
}

/**
 *  移除视图
 *
 *  @param touches
 *  @param event   
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}


/**
 *  在popView 中添加视图
 */

-(void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    _contentView.x = 5;
    _contentView.y= 15;
    
    CGFloat width = self.contentView.frame.size.width ;
    CGFloat height = self.contentView.frame.size.height;
    
    self.popView.bounds = CGRectMake(0, 0,width+10,height+25);
    [self.popView addSubview:_contentView];

    
}





@end
