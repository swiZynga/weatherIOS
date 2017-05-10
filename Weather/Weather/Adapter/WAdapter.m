//
//  WAdapter.m
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WAdapter.h"

@implementation WAdapter

NSString *const weatherList = @"list";
NSString *const city = @"city";
NSString *const cityName = @"name";
NSString *const weatherAttribute = @"main";
NSString *const weatherDescription = @"description";
NSString *const maxTemperature = @"temp_max";
NSString *const minTemperature = @"temp_min";
NSString *const weather = @"weather";
NSString *const weatherTemperature = @"temp";
NSString *const dayName = @"dayName";


- (NSDictionary *)rawDataToDict:(NSData *)data {
    NSDictionary *newDict = [[NSDictionary alloc] init];
    NSError* error;
    newDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return newDict;
}
- (NSMutableArray *)getFiveDays:(NSNumber *)length {
    NSMutableArray *dayList = [[NSMutableArray alloc] init];
    int i = 0;
    while (i < [length integerValue]) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *startDate = [calendar startOfDayForDate:[NSDate date]];
        NSDate *sevenDaysFromNow = [calendar dateByAddingUnit:NSCalendarUnitDay value: i toDate: startDate options: NSCalendarMatchNextTime];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate:sevenDaysFromNow];
        [dayList addObject:dayName];
        ++i;
    }
    
    return dayList;
}

- (NSMutableArray<NSDictionary *> *)dictToArray:(NSDictionary *)dict {
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSMutableArray *check = dict[weatherList];
    NSDictionary *cityList = dict[city];
    NSMutableArray *dayList = [self getFiveDays:[NSNumber numberWithInteger:[dict count]]];
    NSString *location = cityList[cityName];
    NSNumber *weatherListNum = [NSNumber numberWithInteger:[dayList count] - 1];
    for (int i = 0; i <= [weatherListNum integerValue]; ++i) {
        NSMutableArray *weatherArr = check[i][weather];
        NSDictionary *main = check[i][weatherAttribute];
        NSString *weather = [weatherArr objectAtIndex:0][weatherDescription];
        NSNumber *highTemp = main[maxTemperature];
        NSNumber *lowTemp = main[minTemperature];
        NSNumber *current = main[weatherTemperature];
        NSString *date = dayList[i];
        NSDictionary *day = @{weatherDescription:weather, maxTemperature:highTemp, minTemperature:lowTemp, weatherTemperature:current, dayName:date, city:location};
        [newArray addObject:day];
    }
    
    return newArray;
}


- (WModel *)convertDataToModel:(NSData *)data {
    NSDictionary *parsed = [self rawDataToDict:data];
    NSMutableArray *dataList = [self dictToArray:parsed];
    WModel *mInstance = [[WModel alloc] init];
    [self updateModelwith:dataList of:mInstance];
    
    return mInstance;
}


- (NSMutableDictionary *)dataForCells:(WModel *)model {
    NSMutableDictionary *finalData = [[NSMutableDictionary alloc] init];
    NSMutableArray *dayList = [[NSMutableArray alloc] init];
    NSMutableArray *lowTemperatureList = [[NSMutableArray alloc] init];
    NSMutableArray *highTemperatureList = [[NSMutableArray alloc] init];
    NSMutableArray *weatherDescription = [[NSMutableArray alloc] init];
    NSInteger numDays = [model.days count];
    for (int i = 1; i < numDays; ++i) {
        [dayList addObject: model.days[i].name];
        [lowTemperatureList addObject: model.days[i].low];
        [highTemperatureList addObject: model.days[i].high];
        [weatherDescription addObject: model.days[i].weather];
    }
    [finalData setObject:dayList forKey:dayName];
    [finalData setObject:highTemperatureList forKey:maxTemperature];
    [finalData setObject:lowTemperatureList forKey:minTemperature];
    [finalData setObject:weatherDescription forKey:weatherDescription];

    return finalData;
}

- (void)updateModelwith:(NSMutableArray *)data of:(WModel *)model {
    model.days = [[NSMutableArray alloc] init];
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:@"0"];
    for (int i = 0; i < [data count]; ++i) {
        WDayModel *day = [[WDayModel alloc] initWithdayName:data[i][dayName] weatherDesc:data[i][weatherDescription] highTemp:[fmt stringFromNumber:data[i] [maxTemperature]] lowTemp:[fmt stringFromNumber:data[i][minTemperature]] currTemp:[fmt stringFromNumber:data[i][weatherTemperature]] city:data[i][city]];
        [model.days addObject:day];
    }
}

@end
