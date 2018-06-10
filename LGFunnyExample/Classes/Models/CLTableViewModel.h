//
//  CLTableViewModel.h
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLCellModel.h"

@interface CLTableViewModel : NSObject

@property (nonatomic, copy) NSString *titleStr;

@property (nonatomic) NSMutableArray<CLCellModel *> *cellDataArray;

@end
