//
//  WProvider.m
//  Weather
//
//  Created by Sangwook Wi on 5/2/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WProvider.h"

// Api call
NSString *const url = @"http://api.openweathermap.org/data/2.5/forecast?id=";
NSString *const url2 = @"&units=metric&APPID=f33202f4c6383af75e9f7c3057e9a0ad";
NSString *const torontoWeather = @"5174095";
NSString *fullUrl;
NSString *newCityId;

@implementation WProvider

- (void)fetchDataWithCallback:(void (^)(NSData *data, NSError *error))callback {
    if ([self.cityName length] == 0) {
         newCityId = torontoWeather;
    } else {
        NSMutableDictionary *dict = [self citiesFromJSON];
        NSArray *cities = [dict valueForKey:@"name"];
        NSArray *ids = [dict valueForKey:@"id"];
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [cities count]; ++i) {
            [newDict setObject:[ids objectAtIndex:i] forKey:[cities objectAtIndex:i]];
        }
        newCityId = [newDict[self.cityName] stringValue];
        if ([newCityId length]  == 0){
            newCityId = torontoWeather;
        }
    }
    
    fullUrl = [NSString stringWithFormat:@"%@%@%@", url, newCityId, url2];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:fullUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (callback) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        callback(data, error);
                    });
                }
                
            }] resume];
}

- (NSMutableDictionary *)citiesFromJSON {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city.list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


@end
