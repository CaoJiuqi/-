//
//  WeiboDetailMedol.h
//  tensWebProject
//
//  Created by tens on 15-10-13.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"
#import "UserMedol.h"

@interface WeiboDetailMedol : TSBaseMedol

@property (nonatomic,copy)NSString *created_at;

@property (nonatomic,copy)NSString *text;

@property (nonatomic,copy)UserMedol *user;

@end
