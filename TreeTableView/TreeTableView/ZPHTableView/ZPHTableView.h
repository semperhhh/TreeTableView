//
//  ZPHTableView.h
//  TreeTableView
//
//  Created by 张鹏辉 on 2017/4/3.
//  Copyright © 2017年 zph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZPHTableView : UITableView
/**
 数据数组
 */
@property (nonatomic,strong)NSMutableArray *dataArray;
/**
 初始化

 @param frame 位置
 @param style 风格
 @param dataArray 数据字典
 @return 初始化的列表
 */
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataArray:(NSMutableArray *)dataArray;
@end
