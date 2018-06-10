//
//  CLTableViewCell.h
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCellModel.h"

@interface CLTableViewCell : UITableViewCell

- (void)bindWithModel:(CLCellModel *)model;

@end
