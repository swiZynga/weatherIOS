//
//  WDayModel.h
//  Weather
//
//  Created by Sangwook Wi on 5/4/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WDayModel : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *weather;
@property(strong, nonatomic) NSString *high;
@property(strong, nonatomic) NSString *low;
@property(strong, nonatomic) NSString *current;
@property(strong, nonatomic) NSString *cityName;

- (id)initWithdayName:(NSString *)dayName
          weatherDesc:(NSString *)weatherDescription
             highTemp:(NSString *)highTemperature
              lowTemp:(NSString *)lowTemperature
             currTemp:(NSString *)currentTemperature
                 city:(NSString *)location;

@end
