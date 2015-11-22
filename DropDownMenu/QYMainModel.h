//
//  QYMainModel.h
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYMainModel : NSObject
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSArray *listarea;
//当前数据中选中状态
@property (nonatomic) BOOL isSelected;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
