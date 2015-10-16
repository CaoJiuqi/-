//
//  AFHRequestHttp.m
//  tensWebProject
//
//  Created by tens on 15-10-14.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "AFHRequestHttp.h"
#import "AFNetworking.h"


@implementation AFHRequestHttp

+ (void)requestURL:(NSString *)url parameters:(id)parames requestType:(RequestType)type success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    if (type == RequestISGET) {
        NSLog(@"RequestISGET");
        [manager GET:url parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (success) {
                NSLog(@"success");
                success(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                NSLog(@"failure");
                failure(error);
            }
        }];
        
        
    }else if (type == RequestIsPOST)
    {
        [manager POST:url parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(responseObject);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failure) {
                failure(error);
            }
        }];
        
    
    }
    
    
    
    
    
    
}


@end
