//
//  AFHRequestHttp.h
//  tensWebProject
//
//  Created by tens on 15-10-14.
//  Copyright (c) 2015年 tens. All rights reserved.
//

typedef enum:NSInteger
{
    RequestIsPOST,
    RequestISGET
    
}RequestType;

typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(id error);


#import <Foundation/Foundation.h>

@interface AFHRequestHttp : NSObject
/**
 *  该方法是实现网络请求
 *
 *  @param url     请求的链接地址
 *  @param parames 请求的参数
 *  @param type    请求的方式
 *  @param success 请求成功的回调方法
 *  @param failure 请求失败的回调方法
 */
+ (void)requestURL:(NSString *)url parameters:(id)parames requestType:(RequestType)type success:(SuccessBlock)success failure:(FailureBlock)failure;

/**
 *  上传数据
 *
 *  @param URL     请求的链接地址
 *  @param parems  请求参数
 *  @param datas    上传的数据 NSData 格式数组
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)POSTURL:(NSString *)URL parameters:(id)parems datas:(NSArray *)datas success:(SuccessBlock)success failure:(FailureBlock)failure;


@end

