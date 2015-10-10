//
//  UserMedol.h
//  tensWebProject
//
//  Created by tens on 15-10-8.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"

@interface UserMedol : TSBaseMedol

/*用户ID*/
@property (nonatomic,copy)NSString *idstr;

/*用户昵称*/
@property (nonatomic,copy)NSString *screen_name;

/*个人描述*/
@property (nonatomic,copy)NSString *description;

/*户头像地址（中图）*/
@property (nonatomic,copy)NSString *profile_image_url;

/*用户头像地址（大图）*/
@property (nonatomic,copy)NSString *avatar_large;

/*粉丝数*/
@property (nonatomic,strong)NSNumber *followers_count;

/*关注数*/
@property (nonatomic,strong)NSNumber *friends_count;

/*收藏数*/
@property (nonatomic,strong)NSNumber *favourites_count;




@end
