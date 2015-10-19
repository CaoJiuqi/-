//
//  NSString+ToPinyin.m
//  tensWebProject
//
//  Created by tens on 15-10-16.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "NSString+ToPinyin.h"

@implementation NSString (ToPinyin)

-(NSString *)toPinyin
{
    NSMutableString *mutString = [[NSMutableString alloc]init];
    

    CFStringTransform( (CFMutableStringRef) mutString, NULL, kCFStringTransformToLatin, NO);
    
    CFStringTransform((CFMutableStringRef)mutString, NULL, kCFStringTransformStripDiacritics, NO);
    
    [mutString replaceOccurrencesOfString:@"" withString:@" " options:0 range:NSMakeRange(0, mutString.length)];
    
    return mutString;
    
}


@end
