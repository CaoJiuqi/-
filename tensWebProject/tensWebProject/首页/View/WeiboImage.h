//
//  WeiboImage.h
//  tensWebProject
//
//  Created by tens on 15-10-10.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZPhotoBrowser.h"


@interface WeiboImage : UIImageView <HZPhotoBrowserDelegate>

@property (assign , nonatomic) NSArray *imageURLs;

@end
