//
//  emationCell.m
//  tensWebProject
//
//  Created by tens on 15-10-17.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EmationCell.h"
#import "NSString+Emoji.h"


@implementation EmationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.emotionButton = [ UIButton buttonWithType:UIButtonTypeCustom];
        self.emotionButton.frame = self.contentView.bounds;
        self.emotionButton.userInteractionEnabled = NO;
        [self.contentView addSubview:self.emotionButton];
    }
    return self;
}


- (void)setEmotion:(EmotionModel *)emotion
{
    _emotion = emotion;
    
    
    if (_emotion.code) {
        
        [self.emotionButton setTitle:_emotion.code.emoji forState:UIControlStateNormal];
        self.emotionButton.titleLabel.font = [UIFont systemFontOfSize:32];
        
    } else {
        
        [self.emotionButton setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
}


- (void)setItem:(NSInteger)item
{
    _item = item;
    
    [self.emotionButton setImage:nil forState:UIControlStateNormal];
    [self.emotionButton setTitle:nil forState:UIControlStateNormal];
    
    if (_item == 20) {
        
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    }
}


@end
