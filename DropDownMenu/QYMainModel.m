//
//  QYMainModel.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYMainModel.h"
#import "QYSubModel.h"
@implementation QYMainModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *str in self.listarea) {
            QYSubModel *subModel = [QYSubModel modelWithString:str];
            [array addObject:subModel];
        }
        self.listarea = array;
    }
    return self;
}
+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}
@end
