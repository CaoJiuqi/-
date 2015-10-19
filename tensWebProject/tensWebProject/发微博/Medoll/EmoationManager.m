//
//  EmoationManager.m
//  tensWebProject
//
//  Created by tens on 15-10-18.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EmoationManager.h"
#import "EmotionModel.h"

@implementation EmoationManager

+ (NSArray *)loadEmotionData:(NSString *)infoName
{
    NSString *path = [[NSBundle mainBundle]pathForResource:infoName ofType:@"plist"];
    
    NSArray *dictary = [NSDictionary dictionaryWithContentsOfFile:path][@"emoticons"];
    
    NSMutableArray *dictaryMedols = [NSMutableArray array];
    for (NSDictionary *emationdic in dictary) {
        EmotionModel * medol = [[EmotionModel alloc]initWithDictary:emationdic];
        [dictaryMedols addObject:medol];
    }
    return dictaryMedols;
    
}


@end
