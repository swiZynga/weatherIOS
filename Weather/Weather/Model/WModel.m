//
//  WModel.m
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WModel.h"

@implementation WModel


- (id)copyWithZone:(NSZone *)zone {
    WModel *newWModel = [[[self class] allocWithZone:zone] init];
    newWModel.days = [self.days mutableCopy];
    
    return newWModel;
}


@end
