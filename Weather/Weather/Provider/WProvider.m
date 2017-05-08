//
//  WProvider.m
//  Weather
//
//  Created by Sangwook Wi on 5/2/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WProvider.h"
#import "ViewController.h"

// Api call
NSString *const url = @"http://api.openweathermap.org/data/2.5/forecast?id=";
NSString *const url2 = @"&units=metric&APPID=f33202f4c6383af75e9f7c3057e9a0ad";
NSString *fullUrl;

@implementation WProvider

- (void)fetchDataWithCallback:(void (^)(NSData *data, NSError *error))callback
{
    ViewController *new = [[ViewController alloc] init];
    [new cityUserInput:^(NSString *city){
        NSMutableDictionary *dict = [self JSONFromFile];
        NSArray *cities = [dict valueForKey:@"name"];
        NSArray *ids = [dict valueForKey:@"id"];
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [cities count]; ++i) {
            [newDict setObject:[ids objectAtIndex:i] forKey:[cities objectAtIndex:i]];
        }
        NSString *newCityId = [[newDict valueForKey:city] stringValue];
        if (!([newCityId length]  == 0)){
            fullUrl = [NSString stringWithFormat:@"%@%@%@", url, newCityId, url2];
        } else {
            fullUrl = [NSString stringWithFormat:@"%@%@%@", url, @"5174095", url2];
        }
    }];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:fullUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (callback) {
                    callback(data, error);
                }
                
            }] resume];
}

- (NSMutableDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city.list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


@end
