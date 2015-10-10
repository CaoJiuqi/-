//
//  TSWeiboViewCell.m
//  tensWebProject
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSWeiboViewCell.h"
#import "WeiboMedol.h"
#import "UserMedol.h"


@interface TSWeiboViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *leavelImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *sourceLable;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextview;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@end

@implementation TSWeiboViewCell

- (void)awakeFromNib {
    self.toolView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.toolView.layer.borderWidth = 0.5;


    
    
    

}

-(void)setWeiboMedol:(WeiboMedol *)weiboMedol
{
    _weiboMedol = weiboMedol;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_weiboMedol.user.profile_image_url]];
    self.UserNameLable.text = _weiboMedol.user.screen_name;
    self.timeLable.text = _weiboMedol.created_at;
    self.sourceLable.text = _weiboMedol.source;
    self.contentTextview.text = _weiboMedol.text;

    if ([_weiboMedol.reposts_count integerValue] > 0) {
        NSString *sharetitle=[NSString stringWithFormat:@"%@",_weiboMedol.reposts_count];
        [self.shareButton setTitle:sharetitle forState:UIControlStateNormal];
    }
    if ([_weiboMedol.comments_count integerValue]> 0) {
        NSString * commentsCount =[NSString stringWithFormat:@"%@",_weiboMedol.comments_count];
        [self.commentsButton setTitle:commentsCount forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }
    if ([_weiboMedol.attitudes_count integerValue]> 0) {

        NSString *goodstr = [NSString stringWithFormat:@"%@",_weiboMedol.attitudes_count];
        [self.goodButton setTitle:goodstr forState:UIControlStateNormal];
    }
    
}

+(CGFloat)showrangHeight:(WeiboMedol *)medol
{
    
    CGRect rect =[medol.text boundingRectWithSize:CGSizeMake(TSWedth - 20, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}context:nil];
    return rect.size.height + 125;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
