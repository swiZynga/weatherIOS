//
//  WDayModel.m
//  Weather
//
//  Created by Sangwook Wi on 5/4/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WDayModel.h"

@implementation WDayModel

- (id) initWithdayName:(NSString *)dayName weatherDesc:(NSString *)description highTemp:(NSString *)highT lowTemp:(NSString *)lowT currTemp:(NSString *)curT city:(NSString *)location
{
    if (self = [super init]) {
        name = dayName;
        weather = description;
        high = highT;
        low = lowT;
        current = curT;
        cityName = location;
    }
    
    return self;
}

- (NSString *) getName
{
    return name;
}

-(NSString *) getWeather
{
    return weather;
}

-(NSString *) getHigh
{
    return high;
}

-(NSString *) getLow
{
    return low;
}

-(NSString *) getCurrent
{
    return current;
}

-(NSString *) getCityName
{
    return cityName;
}

@end
