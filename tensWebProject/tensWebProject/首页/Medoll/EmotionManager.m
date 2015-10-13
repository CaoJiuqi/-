//
//  EmotionManager.m
//  tensWebProject
//
//  Created by tens on 15-10-12.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EmotionManager.h"

#define DefaultPlist @"defaultInfo"
#define EmojiPlist   @"emojiInfo"
#define LxhInfo      @"lxhInfo"

@implementation EmotionManager

+(NSString *)emotionPNGFromName:(NSString *)name
{

    NSString *path = [[NSBundle mainBundle]pathForResource:DefaultPlist ofType:@"plist"];
    NSDictionary *dictionary  = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *emoticonarray = dictionary[@"emoticons"];
    // cht
    for (NSDictionary *dic in emoticonarray) {
        NSString * nameofplist = dic[@"cht"];
        if ( [nameofplist isEqualToString:name] ) {
            
            return dic[@"png"];
        }
    }
    
    
    
    
//    NSString *path2 = [[NSBundle mainBundle]pathForResource:EmojiPlist ofType:@"plist"];
//    
//    NSString *path3 = [[NSBundle mainBundle]pathForResource:LxhInfo ofType:@"plist"];
    
    
    
    
    
    
    
    
    return nil;
}


@end
