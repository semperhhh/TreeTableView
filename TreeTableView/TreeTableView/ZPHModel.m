//
//  ZPHModel.m
//  TreeTableView
//
//  Created by 张鹏辉 on 2017/4/3.
//  Copyright © 2017年 zph. All rights reserved.
//

#import "ZPHModel.h"

@implementation ZPHModel
+(NSDictionary *)modelContainerPropertyGenericClass {

    return @{@"children":[ZPHModel class]};
}

+(NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id":@"id"};
}
@end
