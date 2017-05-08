//
//  WAdapter.m
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WAdapter.h"

@implementation WAdapter

- (NSDictionary *) rawDataToDict: (NSData *)data
{
    NSDictionary *newDict = [[NSDictionary alloc] init];
    NSError* error;
    newDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    return newDict;
}

- (NSMutableArray *) getFiveDays
{
    NSMutableArray *dayList = [[NSMutableArray alloc] init];
    int i = 0;
    while (i < 5) {
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

- (NSMutableArray *) dictToArray: (NSDictionary *)dict
{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSMutableArray *check = [dict valueForKey:@"list"];
    NSDictionary *cityList = [dict valueForKey:@"city"];
    NSMutableArray *dayList = [self getFiveDays];
    NSString *city = [cityList valueForKey:@"name"];
    for (int i = 0; i <= 4; ++i) {
        NSMutableArray *weatherArr = [check[i] valueForKey:@"weather"];
        NSDictionary *main = [check[i] valueForKey:@"main"];
        NSString *weather = [[weatherArr objectAtIndex:0] valueForKey:@"description"];
        NSNumber *highTemp = [main valueForKey:@"temp_max"];
        NSNumber *lowTemp = [main valueForKey:@"temp_min"];
        NSNumber *current = [main valueForKey:@"temp"];
        NSString *dayName = dayList[i];
        NSDictionary *day = @{@"description":weather, @"high":highTemp, @"low":lowTemp, @"current":current, @"day":dayName, @"city":city};
        [newArray addObject:day];
    }
    
    return newArray;
}


- (WModel *)convertDataToModel:(NSData *)data
{
    
    NSDictionary *parsed = [self rawDataToDict:data];
    NSMutableArray *dataList = [self dictToArray:parsed];
    WModel *mInstance = [[WModel alloc] init];
    [mInstance updateModel:dataList];
    
    return mInstance;
}

@end
