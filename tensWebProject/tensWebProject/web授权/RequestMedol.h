//
//  RequestMedol.h
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"

@interface RequestMedol : TSBaseMedol <NSCoding>

@property (copy,nonatomic)NSString *access_token;
@property (strong,nonatomic)NSNumber *expires_in;
@property (strong,nonatomic)NSNumber *uid;
/* 设置一个保存登陆的时间*/
@property (strong, nonatomic) NSDate *creatDate;


@end
