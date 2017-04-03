//
//  ZPHModel.h
//  TreeTableView
//
//  Created by 张鹏辉 on 2017/4/3.
//  Copyright © 2017年 zph. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPHModel : NSObject
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSArray *children;
/**
 节点,用来区别是第几层
 */
@property (nonatomic,assign)NSInteger node;
/**
 展开,用来判断当前层是否展开
 */
@property (nonatomic,assign)BOOL expansion;
@end

