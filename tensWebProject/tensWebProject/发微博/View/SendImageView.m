//
//  SendImageView.m
//  tensWebProject
//
//  Created by tens on 15-10-15.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SendImageView.h"

@implementation SendImageView


-(NSMutableArray *)photosArray
{
    if (_photosArray == nil) {
        _photosArray = [[NSMutableArray alloc]init];
    }
    return _photosArray;
}

-(NSMutableArray *)delectButtonArray
{
    if (_delectButtonArray == nil) {
        _delectButtonArray = [[NSMutableArray alloc]init];
    }
    return _delectButtonArray;
}


-(void)addPhotos:(NSArray *)photos
{
    [self createPhotoView:photos];
    [self createPhotoViewfream];

}

-(void)createPhotoView:(NSArray *)photos
{
    for (int i = 0; i < photos.count ; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        UIImage *image = photos[i];
        imageView.layer.cornerRadius  = 5;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        imageView.image = image;
        [self.photosArray addObject:imageView];
        
        UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [delectButton setImage:[UIImage imageNamed:@"skin_delete_icon"] forState:UIControlStateNormal];
        delectButton.backgroundColor = [UIColor redColor];
        [delectButton addTarget:self action:@selector(delectImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.delectButtonArray addObject:delectButton];
    }
}

-(void)createPhotoViewfream
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 图片的高度
    CGFloat imageHeight = (TSWedth - 30)/3;
    self.frame = CGRectMake(10, 200, TSWedth - 20, (self.photosArray.count / 3 + 1) * (imageHeight + 5));

    for (int i = 0; i < _photosArray.count ; i++) {
        UIImageView *imageView = self.photosArray[i];
        imageView.frame = CGRectMake((imageHeight+5) * (i % 3) , (imageHeight + 5) *(i / 3), imageHeight, imageHeight);
        [self addSubview:imageView];
        
        UIButton *button = self.delectButtonArray[i];
        button.tag = i;
        CGFloat buttonY = CGRectGetWidth(imageView.frame) - 20;
        button.frame = CGRectMake(buttonY, 0, 20, 20);
        [imageView addSubview:button];
        
    }
}
#pragma mark --Action

-(void)delectImageAction:(UIButton *)button
{
    
    if ([self.delgate respondsToSelector:@selector(delectImageWithIndex:)]) {
        [self.delgate delectImageWithIndex:button.tag];
    }
    [self.photosArray removeObjectAtIndex:button.tag];
    [self.delectButtonArray removeObjectAtIndex:button.tag];
    [UIView animateWithDuration:0.2 animations:^{
        [self createPhotoViewfream];
        
    } ];
    
}

@end
