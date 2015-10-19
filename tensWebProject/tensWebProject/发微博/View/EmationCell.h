//
//  emationCell.h
//  tensWebProject
//
//  Created by tens on 15-10-17.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotionModel.h"

@interface EmationCell : UICollectionViewCell

@property (strong, nonatomic) EmotionModel *emotion;
@property (assign, nonatomic) NSInteger item;


@property (strong, nonatomic) UIButton *emotionButton;

@end
