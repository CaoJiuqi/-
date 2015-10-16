//
//  WeiboDetailMedol.m
//  tensWebProject
//
//  Created by tens on 15-10-13.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "WeiboDetailMedol.h"

@implementation WeiboDetailMedol

-(instancetype)initWithDictary:(NSDictionary *)dic
{
    self = [super initWithDictary:dic];
    if (self) {
        self.user = [[UserMedol alloc]initWithDictary:dic[@"user"]];
    }
    
    return self;
}

@end
