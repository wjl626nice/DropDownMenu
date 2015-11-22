//
//  QYSubModel.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYSubModel.h"

@implementation QYSubModel

-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        _title = title;
    }
    return self;
}
+(instancetype)modelWithString:(NSString *)string
{
    return [[self alloc]initWithTitle:string];
}
@end
