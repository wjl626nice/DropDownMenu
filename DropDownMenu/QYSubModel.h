//
//  QYSubModel.h
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYSubModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic) BOOL isSelected;

-(instancetype)initWithTitle:(NSString *)title;
+(instancetype)modelWithString:(NSString *)string;

@end
