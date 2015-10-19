//
//  EmoationView.h
//  tensWebProject
//
//  Created by tens on 15-10-17.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;

@protocol EmotionKeyboardDelegate <NSObject>

- (void)clickEmotion:(EmotionModel *)emotion withIndex:(NSInteger)index;

@end

@interface EmoationView : UIView

@property (nonatomic,weak)id<EmotionKeyboardDelegate> delegate;

@end
