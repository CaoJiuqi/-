//
//  TSSeaachFieild.m
//  tensWebProject
//
//  Created by tens on 15-10-5.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSSeaachFieild.h"

@implementation TSSeaachFieild

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {

        [self setSeacherText];
    }
    
    return self;
}

-(void)setSeacherText
{
    self.borderStyle = UITextBorderStyleNone;
    UIImage *bgImage = [UIImage imageNamed:@"search_navigationbar_textfield_background"];
    self.background = [bgImage stretchableImageWithLeftCapWidth:5 topCapHeight:5]; ;
    self.placeholder = @"搜索";
    self.clearButtonMode = UITextFieldViewModeAlways;
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_navigationbar_textfield_background"]];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.frame = CGRectMake(0, 0, 30, 20);
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
