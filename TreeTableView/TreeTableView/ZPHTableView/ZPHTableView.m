//
//  ZPHTableView.m
//  TreeTableView
//
//  Created by 张鹏辉 on 2017/4/3.
//  Copyright © 2017年 zph. All rights reserved.
//

#import "ZPHTableView.h"
#import "ZPHModel.h"

@interface ZPHTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZPHTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataArray:(NSMutableArray *)dataArray {
    
    self = [super initWithFrame:frame style:style];
    _dataArray = dataArray;
    self.dataSource = self;
    self.delegate = self;
    return self;
}

#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    ZPHModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.indentationLevel = model.node; //缩进层级
    cell.indentationWidth = 20.0f; //每次缩进寛
    return cell;
}

#pragma mark --UITableViewDelegate
//选中行的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZPHModel *model = _dataArray[indexPath.row];
    NSUInteger startPosition = indexPath.row +1; //开始位置
    NSUInteger endPosition = startPosition;      //结束位置
    BOOL expand = NO;                            //是否展开
    NSInteger expandInt = 0;
    
    if (!model.expansion) {//没有展开就展开
        
        for (ZPHModel *childrenModel in model.children) {
            childrenModel.node = model.node +1;//节点+1
            [_dataArray insertObject:childrenModel atIndex:endPosition];//加入数组
            expand = YES;
            endPosition++;
        }
    }else {//已经展开就闭合
        
        expand = NO;
        endPosition += model.children.count;
        for (ZPHModel *childrenModel in model.children) {
            
            if (childrenModel.expansion) {
                childrenModel.expansion = !childrenModel.expansion;
                expandInt += childrenModel.children.count;
            }
        }
        [_dataArray removeObjectsInRange:NSMakeRange(startPosition, endPosition-startPosition +expandInt)];//从数组删除
    }
    
    model.expansion = !model.expansion;//展开状态
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition +expandInt; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //插入或者删除相关节点
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
