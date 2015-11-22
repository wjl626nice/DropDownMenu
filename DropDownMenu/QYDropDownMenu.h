//
//  QYDropDownMenu.h
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYDropDownMenuDelegate <NSObject>

-(void)didSelectedMenuMainTableViewRow:(NSInteger)mainRow subTableViewRow:(NSInteger)subRow;

@end

typedef NS_ENUM(NSInteger, QYDropDownMenuType) {
    QYDropDownMenuTypeSingleColumn,//单列
    QYDropDownMenuTypeDoubleColumnSingleSelection,//双列，单选
    QYDropDownMenuTypeDoubleColumnDoubleSelection //双列，多选
};

@interface QYDropDownMenu : UIView
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic)QYDropDownMenuType menuType;
@property (nonatomic, assign)id <QYDropDownMenuDelegate> delegate;

@property (nonatomic, strong)NSArray *selectedRows;
@end
