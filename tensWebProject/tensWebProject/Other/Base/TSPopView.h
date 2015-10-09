//
//  TSPopView.h
//  tensWebProject
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PopViewLeft,
    PopViewCenter,
    PopViewRight
} PopViewType;

@interface TSPopView : UIView

@property (nonatomic,strong)UIView *contentView;

-(void)showPopView:(UIView *)view WithType:(PopViewType)type;

@end
