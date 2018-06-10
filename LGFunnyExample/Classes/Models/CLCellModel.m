//
//  CLCellModel.m
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import "CLCellModel.h"

@implementation CLCellModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"titleStr" : @"title",
             @"descriptionStr" : @"description",
             @"imageHref" : @"imageHref",
             };
}

@end
