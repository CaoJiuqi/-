//
//  NewsMedol.h
//  tensWebProject
//
//  Created by tens on 15-10-8.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"
#import "UserMedol.h"

@interface NewsMedol : TSBaseMedol

/*微博创建时间*/
@property (nonatomic,copy)NSString *created_at;
/*微博信息内容*/
@property (nonatomic,copy)NSString *text;
/*微博来源*/
@property (nonatomic,copy)NSString *source;
/*评论数*/
@property (assign,nonatomic)NSNumber *comments_count;
/*转发数*/
@property (assign,nonatomic)NSNumber *reposts_count;
/*微博作者的用户信息字段*/
@property (nonatomic,strong)UserMedol *user;

@end
