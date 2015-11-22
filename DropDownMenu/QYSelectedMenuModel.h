//
//  QYSelectedMenuModel.h
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSelectedMenuModel : NSObject
@property (nonatomic) NSInteger mainRow;
@property (nonatomic) NSInteger subRow;

-(instancetype)initWithMainRow:(NSInteger)mainRow SubRow:(NSInteger)subRow;
+(instancetype)modelWithMainRow:(NSInteger)mainRow SubRow:(NSInteger)subRow;
@end
