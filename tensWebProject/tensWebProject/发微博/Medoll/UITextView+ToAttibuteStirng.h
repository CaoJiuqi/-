//
//  UITextView+ToAttibuteStirng.h
//  TensWeibo_Demo
//
//  Created by qinglinfu on 15/10/17.
//  Copyright (c) 2015年 十安科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;

@interface UITextView (ToAttibuteStirng)

/**
 *  将表情的名称转为对应的表情图片
 *
 *  @param emotion EmotionModel
 */
- (void)insertEmotion:(EmotionModel *)emotion;


/**
 *  将表情图片转为对应的表情名称
 *
 *  @param attStr NSAttributedString
 *
 *  @return 转化后的NSString
 */
- (NSString *)attributeStrinToString:(NSAttributedString *)attStr;


@end
