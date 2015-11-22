//
//  QYDropDownMenu.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "QYDropDownMenu.h"
#import "QYMainModel.h"
#import "QYSubModel.h"
#import "QYTableViewCell.h"
#import "QYSelectedMenuModel.h"
@interface QYDropDownMenu ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *mainTableView;
@property (nonatomic, strong)UITableView *subTableView;

@property (nonatomic)NSInteger mainTableViewSelectedRow;
@end


@implementation QYDropDownMenu


-(void)setSelectedRows:(NSArray *)selectedRows
{
    _selectedRows = selectedRows;
    
    NSLog(@"%@",selectedRows);
    _mainTableViewSelectedRow = [[selectedRows firstObject] mainRow];
    
    NSLog(@"%ld",_mainTableViewSelectedRow);
    
    //把数据中所有的isSelected设置成NO
    [self setNoforModelIsSelected];
    
    //根据selectedRows更改数据中的isSelected
    for (QYSelectedMenuModel *selectedModel in selectedRows) {
        NSInteger mainSelectedRow = selectedModel.mainRow;
        NSInteger subSelectedRow = selectedModel.subRow;
        
        //根据mainSelectedRow设置主表中数据的isSelected，根据subSelectedRow设置从表中数据的isSelected。
        [self setYesForMainModelIsSelected:mainSelectedRow subModelIsSelected:subSelectedRow];
    }
    
    
    [_mainTableView reloadData];
    [_subTableView reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2.0, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:mainTableView];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        [mainTableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:@"cell"];
        _mainTableView = mainTableView;
        
        UITableView *subTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width / 2.0, 0, frame.size.width / 2.0, frame.size.height) style:UITableViewStylePlain];
        [self addSubview:subTableView];
        subTableView.delegate = self;
        subTableView.dataSource = self;
        [subTableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:@"cell"];
        _subTableView = subTableView;
    }
    return self;
}



#pragma mark - 数据源

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainTableView) {
        return _datas.count;
    }else{
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        return mainModel.listarea.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(tableView == _mainTableView){
        QYMainModel *mainModel = _datas[indexPath.row];
        cell.mainModel = mainModel;
    }else{
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        QYSubModel *subModel = mainModel.listarea[indexPath.row];
        cell.subModel = subModel;
    }
    
    return cell;
}


#pragma mark - 委托
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.menuType) {
        case QYDropDownMenuTypeSingleColumn:
            [self singleTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
        case QYDropDownMenuTypeDoubleColumnSingleSelection:
            [self singleSelectionDoubelTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
        case QYDropDownMenuTypeDoubleColumnDoubleSelection:
            [self doubleSelectionDoubelTableView:tableView didSelectedRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
    }
}
//单表，单选
-(void)singleTableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)path
{
    //设置主表数据中isSelected为NO
    [self setNoForMainModelIsSelected];
    
    //把选中的行的isSelected为YES
    QYMainModel *mainModel = _datas[path.row];
    mainModel.isSelected = YES;
    
    //刷新表格
    [_mainTableView reloadData];
    
    //返回数据
    if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableViewRow:)]) {
        [self.delegate didSelectedMenuMainTableViewRow:path.row subTableViewRow:-1];
    }
}
//双表，单选
-(void)singleSelectionDoubelTableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)path
{
    if (tableView == _mainTableView) {
       //设置主表数据的选中状态（把全部的数据的isSelected设置成NO）
        [self setNoForMainModelIsSelected];
        //把当前选中的行数据的isSelected设置成YES
        QYMainModel *mainModel = _datas[path.row];
        mainModel.isSelected = YES;
        
        //设置主表选中的行_mainTableViewSelectedRow
        _mainTableViewSelectedRow = path.row;
        
        //刷新主从表
        [_mainTableView reloadData];
        [_subTableView reloadData];
    }else{
        //把主从表所对应的数据中的isSelected全部设置为NO
        [self setNoforModelIsSelected];
        //设置主表的数据中isSelected 为YES
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        mainModel.isSelected = YES;
        //设置从表数据中isSelected 为YES
        QYSubModel *subModel = mainModel.listarea[path.row];
        subModel.isSelected = YES;
        //刷新从表
        [_subTableView reloadData];
        //返回数据
        if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableViewRow:)]) {
            [self.delegate didSelectedMenuMainTableViewRow:_mainTableViewSelectedRow subTableViewRow:path.row];
        }
        
    }
}

//设置主表数据中isSelected为NO
-(void)setNoForMainModelIsSelected
{
    for (QYMainModel *model in _datas) {
        model.isSelected = NO;
    }
}

//把所有的数据中的isSelected设置为NO
-(void)setNoforModelIsSelected
{
    for (QYMainModel *model in _datas) {
        model.isSelected = NO;
        for (QYSubModel *subModel in model.listarea) {
            subModel.isSelected = NO;
        }
    }
}

//双表，多选
-(void)doubleSelectionDoubelTableView:(UITableView *)tableView didSelectedRowAtIndexPath:(NSIndexPath *)path
{
    if (tableView == _mainTableView) {
        //根据从表中是否有选中的行，来决定是否是选中状态
        [self setValueForMainModelIsSelectedWithSubModelIsSelected];
        //更改当前选中的行的isSelected
        QYMainModel *mainModel = _datas[path.row];
        mainModel.isSelected = YES;
        //设置主表选中的行_mainTableViewSelectedRow
        _mainTableViewSelectedRow = path.row;
        //是刷新表格
        [_mainTableView reloadData];
        [_subTableView reloadData];
    }else{
        //把当前选中主表的行对应的子表的数据的isSelected设置为NO
        [self setNoForSubModelIsSelected:_mainTableViewSelectedRow];
        //更改当前选中的字表的行的isSelected为YES
        QYMainModel *mainModel = _datas[_mainTableViewSelectedRow];
        
        QYSubModel *subModel = mainModel.listarea[path.row];
        subModel.isSelected = YES;
        //刷新子表
        [_subTableView reloadData];
        
        //返回值
        
        if ([self.delegate respondsToSelector:@selector(didSelectedMenuMainTableViewRow:subTableViewRow:)]) {
            [self.delegate didSelectedMenuMainTableViewRow:_mainTableViewSelectedRow subTableViewRow:path.row];
        }
    }
}

-(void)setNoForSubModelIsSelected:(NSInteger)mainSelectedRow
{
    QYMainModel *mainModel = _datas[mainSelectedRow];
    for (QYSubModel *subModel in mainModel.listarea) {
        subModel.isSelected = NO;
    }
}

//根据从表中是否有选中的行，来决定是否是选中状态
-(void)setValueForMainModelIsSelectedWithSubModelIsSelected
{
    for (QYMainModel *mainModel in _datas) {
        BOOL selected = NO;
        
        for (QYSubModel *subModel in mainModel.listarea) {
            if (subModel.isSelected) {
                selected = YES;
                break;
            }
        }
        if (selected) {
            mainModel.isSelected = YES;
        }else{
            mainModel.isSelected = NO;
        }
    }
}

//根据mainSelectedRow设置主表中数据的isSelected，根据subSelectedRow设置从表中数据的isSelected。
-(void)setYesForMainModelIsSelected:(NSInteger)mainSelectedRow subModelIsSelected:(NSInteger)subSelectedRow
{
    QYMainModel *mainModel = _datas[mainSelectedRow];
    mainModel.isSelected = YES;
    
    if (self.menuType != QYDropDownMenuTypeSingleColumn) {
        QYSubModel *subModel = mainModel.listarea[subSelectedRow];
        subModel.isSelected = YES;
    }
}
@end
