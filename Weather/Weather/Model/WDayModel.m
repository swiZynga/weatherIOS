//
//  WDayModel.m
//  Weather
//
//  Created by Sangwook Wi on 5/4/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WDayModel.h"

@implementation WDayModel

- (id)initWithdayName:(NSString *)dayName weatherDesc:(NSString *)description highTemp:(NSString *)highT lowTemp:(NSString *)lowT currTemp:(NSString *)curT {
    if (self = [super init]) {
        _name = dayName;
        _weather = description;
        _high = highT;
        _low = lowT;
        _current = curT;
    }
    
    return self;
}


@end
