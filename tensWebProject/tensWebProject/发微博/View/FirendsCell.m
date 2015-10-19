//
//  FirendsCell.m
//  tensWebProject
//
//  Created by tens on 15-10-16.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "FirendsCell.h"
#import "UserMedol.h"

@interface FirendsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;



@end

@implementation FirendsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setMedol:(UserMedol *)medol
{
    _medol = medol;
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:_medol.profile_image_url]];
    self.nameLable.text = _medol.screen_name;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
