//
//  UITextView+ToAttibuteStirng.m
//  TensWeibo_Demo
//
//  Created by qinglinfu on 15/10/17.
//  Copyright (c) 2015年 十安科技. All rights reserved.
//

#import "UITextView+ToAttibuteStirng.h"
#import "TSTextAttachment.h"

@implementation UITextView (ToAttibuteStirng)


- (void)insertEmotion:(EmotionModel *)emotion
{
    TSTextAttachment *achment = [[TSTextAttachment alloc] init];
    achment.emotion = emotion;
    
    achment.image = [UIImage imageNamed:emotion.png];
    UIFont *font = [UIFont systemFontOfSize:15];
    achment.bounds = CGRectMake(0, -4, font.lineHeight + 1.5, font.lineHeight + 1.5);
    NSAttributedString *emotionAttStr = [NSAttributedString attributedStringWithAttachment:achment];
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSUInteger location = self.selectedRange.location;
    [attributeStr insertAttributedString:emotionAttStr atIndex:location];
    [attributeStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributeStr.length)];
    
    self.attributedText = attributeStr;
    
    self.selectedRange = NSMakeRange(location + 1, 0);
    
}


- (NSString *)attributeStrinToString:(NSAttributedString *)attStr
{
    NSMutableString *mutStr = [[NSMutableString alloc] init];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, attStr.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        
        TSTextAttachment *achment = attrs[@"NSAttachment"];
        if (achment) {
            // 拼接表情的名称
            [mutStr appendString:achment.emotion.chs];
            
        } else {
            
            // 拼接非表情的文本
            [mutStr appendString:[attStr attributedSubstringFromRange:range].string];
        }
        
    }];
    
    return mutStr;
}

@end
