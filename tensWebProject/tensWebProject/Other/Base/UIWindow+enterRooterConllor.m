//
//  UIWindow+enterRooterConllor.m
//  tensWebProject
//
//  Created by tens on 15-10-8.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "UIWindow+enterRooterConllor.h"

@implementation UIWindow (enterRooterConllor)

-(void)enterConllor
{
    // 获取当期APP的版本号
    NSDictionary *dictionary = [NSBundle mainBundle].infoDictionary;
    NSString *visionNum = dictionary[@"CFBundleVersion"];
    
    // 获取存储的版本号
    NSString *newVisionNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"vision"];
    
    if (![visionNum isEqualToString:newVisionNum]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"WelComeViewController"];
        //保存版本号
        [[NSUserDefaults standardUserDefaults]setValue:visionNum forKey:@"vision"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.rootViewController = [storyboard instantiateInitialViewController];
    }
    

}

@end
