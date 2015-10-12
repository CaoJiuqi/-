//
//  WeiboImage.m
//  tensWebProject
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboImage.h"
#import "HZPhotoBrowser.h"


@interface WeiboImage () 

@end

@implementation WeiboImage

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.superview;
    browser.imageCount = self.imageURLs.count;
    browser.currentImageIndex = (int)self.tag;
    browser.delegate = self;
    
    [browser show];
    
}
#pragma mark - <HZPhotoBrowserDelegate>
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.superview.subviews[index] image];;
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = _imageURLs[index][@"thumbnail_pic"];
    // 将缩略图换为高清图显示
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}

@end
