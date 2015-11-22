//
//  ViewController.m
//  DropDownMenu
//
//  Created by newqingyun on 15/11/12.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "QYMainModel.h"
#import "QYDropDownMenu.h"
#import "QYSelectedMenuModel.h"
@interface ViewController ()<QYDropDownMenuDelegate>
@property (nonatomic, strong)NSArray *array1;
@property (nonatomic, strong)NSArray *array2;
@property (nonatomic, strong)NSArray *array3;

@property (nonatomic, strong)NSArray *selelctedArray1;
@property (nonatomic, strong)NSArray *selelctedArray2;
@property (nonatomic, strong)NSMutableArray *selelctedArray3;

@property (nonatomic, strong)QYDropDownMenu *menu;
@end

@implementation ViewController

-(NSMutableArray *)getArrayFromFile:(NSString *)filePath
{
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        QYMainModel *mainModel = [QYMainModel modelWithDictionary:dict];
        [models addObject:mainModel];
    }
    return models;
}

//获取城市区域以及街道 101
-(void)getAreaAndDetailArea{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *parameterString=[NSString stringWithFormat:@"{\"commandcode\":%d,\"REQUEST_BODY\":{\"city\":\"%@\"}}",101,@"昆明"];
    NSDictionary *loginParameters =@{@"HEAD_INFO":parameterString};
    
    [manager POST:@"http://www.fungpu.com/houseapp/apprq.do" parameters:loginParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithDictionary:responseObject];
        NSDictionary *dict = dic[@"RESPONSE_BODY"];
        NSArray *array = dict[@"list"];
        //NSLog(@"%@",responseObject);
        NSLog(@"%@",array);
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYMainModel *mainModel = [QYMainModel modelWithDictionary:dict];
            [models addObject:mainModel];
        }
        _array1 = models;
        
        _array2 = [self getArrayFromFile:[[NSBundle mainBundle] pathForResource:@"SiftZLP" ofType:@"plist"]];
        
        _array3 = [self getArrayFromFile:[[NSBundle mainBundle] pathForResource:@"SiftZMore" ofType:@"plist"]];
        [self addDropDownMenu];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1://区域
        {
            _menu.menuType = QYDropDownMenuTypeDoubleColumnSingleSelection;
            _menu.datas = _array1;
            _menu.selectedRows = _selelctedArray1;
        }
            break;
        case 2://价格
        {
            _menu.menuType = QYDropDownMenuTypeSingleColumn;
            _menu.datas = _array2;
            _menu.selectedRows = _selelctedArray2;
        }
            break;
        case 3://更多
        {
            _menu.menuType = QYDropDownMenuTypeDoubleColumnDoubleSelection;
            _menu.datas = _array3;
            _menu.selectedRows = _selelctedArray3;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - QYDropDownMenuDelegate
-(void)didSelectedMenuMainTableViewRow:(NSInteger)mainRow subTableViewRow:(NSInteger)subRow
{
    NSLog(@"mainRow:%ld----subRow:%ld",(long)mainRow,(long)subRow);
    QYSelectedMenuModel *selectedModel = [QYSelectedMenuModel modelWithMainRow:mainRow SubRow:subRow];
    switch (_menu.menuType) {
        case QYDropDownMenuTypeSingleColumn:
        {
            _selelctedArray2 = @[selectedModel];
        }
            break;
        case QYDropDownMenuTypeDoubleColumnSingleSelection:
        {
            _selelctedArray1 = @[selectedModel];
        }
            break;
        case QYDropDownMenuTypeDoubleColumnDoubleSelection:
        {
            NSMutableArray *willRemove = [NSMutableArray array];
            for (QYSelectedMenuModel *model in _selelctedArray3) {
                if (model.mainRow == selectedModel.mainRow) {
                    [willRemove addObject:model];
                }
            }
            [_selelctedArray3 removeObjectsInArray:willRemove];
            [_selelctedArray3 addObject:selectedModel];
        }
            break;
            
        default:
            break;
    }
}

-(void)addDropDownMenu
{
    _menu = [[QYDropDownMenu alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 400)];
    [self.view addSubview:_menu];
    _menu.menuType = QYDropDownMenuTypeDoubleColumnSingleSelection;
    _menu.delegate = self;
    _menu.datas = _array1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selelctedArray3 = [NSMutableArray array];
    
    [self getAreaAndDetailArea];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
