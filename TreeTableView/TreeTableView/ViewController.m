//
//  ViewController.m
//  TreeTableView
//
//  Created by 张鹏辉 on 2017/3/31.
//  Copyright © 2017年 zph. All rights reserved.
//

#import "ViewController.h"
#import "ZPHTableView.h"
#import <YYKit/NSObject+YYModel.h>//字典转模型
#import "ZPHModel.h"//模型

@interface ViewController ()
/**
 树形列表
 */
@property (nonatomic,strong)ZPHTableView *zphTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //读取本地的json数据
    NSError *error;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"tree" ofType:@"json"];
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];//根据文件路径读取数据
    NSDictionary *messageDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    
    //字典转模型
    NSArray *array = [NSMutableArray arrayWithObject:messageDictionary];
    NSMutableArray *nmArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        ZPHModel *model = [ZPHModel modelWithJSON:dict];
        model.expansion = NO;//节点默认是不展开的
        model.node = 0;//第一层节点
        [nmArray addObject:model];
    }
    
    _zphTableView = [[ZPHTableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height -20) style:UITableViewStylePlain dataArray:nmArray];//初始化列表
    [self.view addSubview:_zphTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
