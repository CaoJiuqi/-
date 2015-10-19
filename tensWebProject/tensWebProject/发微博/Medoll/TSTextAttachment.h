//
//  TSTextAttachment.h
//  tensWebProject
//
//  Created by tens on 15-10-18.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"
#import "EmotionModel.h"

@interface TSTextAttachment : NSTextAttachment

@property(nonatomic,strong)EmotionModel *emotion;

@end
