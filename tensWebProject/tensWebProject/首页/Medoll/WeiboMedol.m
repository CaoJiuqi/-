//
//  NewsMedol.m
//  tensWebProject
//
//  Created by tens on 15-10-8.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboMedol.h"
#import "UserMedol.h"
#import "ToatterString.h"

@implementation WeiboMedol

-(instancetype)initWithDictary:(NSDictionary *)dic
{
    self = [super initWithDictary:dic];
    if (self) {
        self.user = [[UserMedol alloc]initWithDictary:dic[@"user"]];
    }
    return self;
    
}

-(void)setCreated_at:(NSString *)created_at
{

    //  Fri Oct 09 15:13:58 +0800 2015--->15-10-09 00:13,
    // 不同格式时间之间的转化
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss zz yyyy";

    NSDate *date = [formatter dateFromString:created_at];
    
    formatter.dateFormat = @"yy-MM-dd HH:mm";
    NSString *datestr = [formatter stringFromDate:date];
    _created_at = datestr;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    
    if ([key isEqualToString:@"pic_ids"]) {
        self.pic_urls = [[NSArray alloc]initWithArray:value];
    }
    
    if ([key isEqualToString:@"retweeted_status"]) {
        
        self.retweetedWeibo = [[WeiboMedol alloc]initWithDictary:value];
    }

    
}


-(void)setSource:(NSString *)source
{
    // 截取来源数据的某一部分
    NSRange rang1 = [source rangeOfString:@">"];
    NSRange rang2 = [source rangeOfString:@"</a>"];
    NSRange rang = {rang1.location + 1,rang2.location - rang1.location -1};
    if (rang1.location != NSNotFound && rang2.location != NSNotFound) {
        _source= [source substringWithRange:rang];
    }
}



@end
