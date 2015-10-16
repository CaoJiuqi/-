//
//  WeiboDetailCell.m
//  tensWebProject
//
//  Created by tens on 15-10-13.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboDetailCell.h"
#import "ToatterString.h"

@interface WeiboDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UILabel *dataLable;
@property (weak, nonatomic) IBOutlet UITextView *commentesTextView;
@end

@implementation WeiboDetailCell

-(void)setMedol:(WeiboDetailMedol *)medol
{
    _medol = medol;
    
    
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:_medol.user.profile_image_url]];
    self.userNameLable.text = _medol.user.screen_name;
    self.dataLable.text = _medol.created_at;
    self.commentesTextView.attributedText = [ToatterString attributeStringfromString:_medol.text withFont:[UIFont systemFontOfSize:13]];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
