//
//  EmotionManager.h
//  tensWebProject
//
//  Created by tens on 15-10-12.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionManager : NSObject

/**
 *  该方法是 通过表情文字 获取相应的表情图片的名字
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)emotionPNGFromName:(NSString *)name;

@end
