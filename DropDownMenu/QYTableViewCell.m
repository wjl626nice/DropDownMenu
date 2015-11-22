//
//  QYTableViewCell.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
@implementation QYTableViewCell

-(void)setMainModel:(QYMainModel *)mainModel
{
    _mainModel = mainModel;
    
    self.textLabel.text = mainModel.area;
    if (mainModel.isSelected) {
        self.textLabel.textColor = [UIColor blueColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
}

-(void)setSubModel:(QYSubModel *)subModel
{
    _subModel = subModel;
    self.textLabel.text = subModel.title;
    if (subModel.isSelected) {
        self.textLabel.textColor = [UIColor blueColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
