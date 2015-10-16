//
//  SendWebView.h
//  tensWebProject
//
//  Created by tens on 15-10-6.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import <UIKit/UIKit.h>



/*定义一个枚举*/
typedef NS_ENUM (long, SendWeiboItemType) {
    
    SendWeiboItemIsText = 0, // 纯文本
    SendWeiboItemIsAlbum,    // 相册
    SendWeiboItemIsCamera    // 相机
};

@protocol sendWeiboDelegate<NSObject>

-(void)OnClickDelegte:(SendWeiboItemType)itemType;

@end


@interface SendWebView : UIView

@property(weak,nonatomic)id<sendWeiboDelegate> delege;

-(void)showView;
+(instancetype)create;


@end
