//
//  WDayModel.h
//  Weather
//
//  Created by Sangwook Wi on 5/4/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDayModel : NSObject
{
    NSString *name;
    NSString *weather;
    NSString *high;
    NSString *low;
    NSString *current;
    NSString *cityName;
}

-(NSString *) getName;
-(NSString *) getWeather;
-(NSString *) getHigh;
-(NSString *) getLow;
-(NSString *) getCurrent;
-(NSString *) getCityName;

- (id) initWithdayName:(NSString *)dayName
           weatherDesc:(NSString *)description
              highTemp:(NSString *)highT
               lowTemp:(NSString *)lowT
              currTemp:(NSString *)curT
                  city:(NSString *)location;

@end
