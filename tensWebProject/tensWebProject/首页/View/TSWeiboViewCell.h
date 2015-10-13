//
//  TSWeiboViewCell.h
//  tensWebProject
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboMedol;

@interface TSWeiboViewCell : UITableViewCell

@property (nonatomic,strong)WeiboMedol *weiboMedol;

+(CGFloat)showrangHeight:(WeiboMedol *)medol;
- (CGFloat)setImageViewHeight:(WeiboMedol *)medol;



@end
