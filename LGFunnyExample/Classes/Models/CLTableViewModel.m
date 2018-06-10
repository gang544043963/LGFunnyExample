//
//  CLTableViewModel.m
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import "CLTableViewModel.h"
#import <YYModel/YYModel.h>

@implementation CLTableViewModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
                 @"titleStr" : @"title",
                 @"cellDataArray" : @"rows",
             };
}

- (NSMutableArray<CLCellModel *> *)cellDataArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (_cellDataArray.count > 0) {
        for (NSDictionary *dict in _cellDataArray) {
            CLCellModel *cellModel = [CLCellModel yy_modelWithJSON:dict];
            if (cellModel) {
                [array addObject:cellModel];
            }
        }
    }
    return array;
}

@end
