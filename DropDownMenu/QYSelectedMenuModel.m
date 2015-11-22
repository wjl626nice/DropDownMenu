//
//  QYSelectedMenuModel.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYSelectedMenuModel.h"

@implementation QYSelectedMenuModel
-(instancetype)initWithMainRow:(NSInteger)mainRow SubRow:(NSInteger)subRow
{
    if (self = [super init]) {
        _mainRow = mainRow;
        _subRow = subRow;
    }
    return self;
}
+(instancetype)modelWithMainRow:(NSInteger)mainRow SubRow:(NSInteger)subRow
{
    return [[self alloc]initWithMainRow:mainRow SubRow:subRow];
}
@end
