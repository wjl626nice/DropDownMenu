//
//  QYTableViewCell.h
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYMainModel;
@class QYSubModel;
@interface QYTableViewCell : UITableViewCell
@property (nonatomic, strong)QYMainModel *mainModel;
@property (nonatomic, strong)QYSubModel *subModel;
@end
