//
//  TSMedolFather.m
//  MyTensNews
//
//  Created by tens on 15-8-26.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSBaseMedol.h"


@implementation TSBaseMedol
-(instancetype)initWithDictary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //通过KVO 键值对的形式来 给响应的属性强行赋值，当字典中有的key值，当前类的属性没有的值会发生错误，
        //通过 覆写setValue:(id)value forUndefinedKey 方法 ，
        if ([dic isKindOfClass:(NSDictionary.class)]) {
            [self setValuesForKeysWithDictionary:dic];
        }
    }
    return self;
}

//该方法可以事项过滤掉字典有，而属性没有，并不需要具体写什么 ，这是NSObject 的一个方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
