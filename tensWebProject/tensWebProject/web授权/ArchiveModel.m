//
//  ArchiveModel.m
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"archiveMedol.plist"]
#import "ArchiveModel.h"
#import "RequestMedol.h"

@implementation ArchiveModel

/**
 * 对RequestMedol 数据进行存档
 *
 *  @param model数据
 */
+ (void)ArchiveModel:(RequestMedol *)model
{
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
}

/**
 *  获取存档信息
 *
 *  @return model
 */
+ (RequestMedol *)UnArichiveMedol
{
   RequestMedol *model =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    model.expires_in = @30;
    NSDate *currentDate = [NSDate date];
    NSDate *oldDate = [model.creatDate dateByAddingTimeInterval:[model.expires_in doubleValue]];
    NSComparisonResult result = [currentDate compare:oldDate];
    
    // 超过截止时间
    if (result == NSOrderedDescending ) {
        return nil;
    }
    
    
    return  model;
}

@end
