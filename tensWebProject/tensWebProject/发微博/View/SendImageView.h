//
//  SendImageView.h
//  tensWebProject
//
//  Created by tens on 15-10-15.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol delectDelgate <NSObject>

-(void)delectImageWithIndex:(NSInteger )index;

@end


@interface SendImageView : UIView

@property(nonatomic,strong)NSMutableArray *photosArray;
@property(nonatomic,strong)NSMutableArray *delectButtonArray;

@property(nonatomic,strong)id<delectDelgate> delgate;

/**
 *  添加图片视图
 *
 *  @param photos 图片数组
 */
-(void)addPhotos:(NSArray *)photos;

@end
