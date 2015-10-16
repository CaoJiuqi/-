//
//  toatterString.m
//  tensWebProject
//
//  Created by tens on 15-10-12.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "ToatterString.h"
#import "EmotionManager.h"



@implementation ToatterString

+ (NSAttributedString *)attributeStringfromString:(NSString *)string withFont:(UIFont *)font
{
    NSMutableAttributedString *attribuStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 第一个字符为@
    NSString *pattAt = @"@[\\w-]+";
    
    // 匹配话题#fhsaf#
    NSString *pattTopic = @"#[\\w-]+#";
    
    // https://baidu.com/
    NSString *pattURL = @"https?://[\\w-+&\\/.]+";
    
    // 匹配表情[哈哈]
    NSString *pattEmotion = @"\\[[\\w-]+\\]";
    
    // 包含多个表达式的条件
    NSString *pattAll = [NSString stringWithFormat:@"%@|%@|%@|%@",pattAt,pattTopic,pattURL,pattEmotion];
    
    
    // 2、根据这个表达式找出符合规则的字符串:NSRegularExpression
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattAll options:0 error:nil];
    NSRange range = {0,string.length};
    
    __block NSUInteger lengthCount = 0;
    [regex enumerateMatchesInString:string options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSString *subString = [string substringWithRange:result.range];
        //[哈哈] 或群相应的图片文字
        NSString *imageName = [EmotionManager emotionPNGFromName:subString];
        
        if (imageName) {
//            NSLog(@"emotion: %@",imageName); 
            
            // 获取表情名称所对应的表情图片名称
            NSTextAttachment *achment = [[NSTextAttachment alloc] init];
            achment.image = [UIImage imageNamed:imageName];
            achment.bounds = CGRectMake(0, 0, 15, 15);
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:achment];
            NSRange emotionRange = {result.range.location - lengthCount ,subString.length};
            [attribuStr replaceCharactersInRange:emotionRange withAttributedString:imageStr];
            lengthCount += subString.length - 1;
        } else {
            // 如果不是图片就要进行超链接
            [attribuStr addAttribute:NSLinkAttributeName value:subString range:NSMakeRange(result.range.location - lengthCount, subString.length)];
        }
        
    }];
    
    [attribuStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attribuStr.length)];
    


    
    
    return attribuStr;
    
}


@end
