//
//  weiboImageView.m
//  tensWebProject
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "weiboImageView.h"
#import "WeiboImage.h"


@interface weiboImageView ()
{
    NSArray *_subViews;
}

@end

@implementation weiboImageView


-(void)awakeFromNib
{
     _subViews = self.subviews;
    
}

- (void)setImageImageURLs:(NSArray *)imageImageURLs
{
    
    
    _imageImageURLs = imageImageURLs;
    
    [self setImageViews];
}



-(void)setImageViews
{
    for (int i = 0 ; i < _subViews.count; i++) {
        
        WeiboImage *imageView = _subViews[i];
        

        imageView.imageURLs = _imageImageURLs;

        if (i >= _imageImageURLs.count) {
            imageView.hidden = YES;
        }
        else
        {
            imageView.hidden = NO;
            NSString *urlstr = _imageImageURLs[i][@"thumbnail_pic"];
            urlstr =  [urlstr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle" ];
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
            
        }
    }
    
}

@end
