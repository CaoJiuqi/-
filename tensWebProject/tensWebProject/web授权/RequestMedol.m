//
//  RequestMedol.m
//  tensWebProject
//
//  Created by tens on 15-10-7.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "RequestMedol.h"

@implementation RequestMedol

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    self.creatDate = [NSDate date];
}


/**
 *  这是给属性加密
 *
 *  @param coder 
 */
-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeObject:self.expires_in forKey:@"expires_in"];
    [coder encodeObject:self.uid forKey:@"uid"];
    [coder encodeObject:self.creatDate forKey:@"creatDate"];
    
}

/**
 *  给对应的属性解密
 *
 *  @param aDecoder
 *
 *  @return
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
       self.access_token =  [aDecoder decodeObjectForKey:@"access_token"];
       self.expires_in =  [aDecoder decodeObjectForKey:@"expires_in"];
       self.uid = [aDecoder decodeObjectForKey:@"uid"];
       self.creatDate = [aDecoder decodeObjectForKey:@"creatDate"];
    }
    return self;
}
@end
