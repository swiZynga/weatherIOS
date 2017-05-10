//
//  WCenter.m
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WCenter.h"
#import "WProvider.h"
#import "WAdapter.h"

@interface WCenter()

@end


@implementation WCenter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static WCenter *instance;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.cityInput = @"";
    }
    
    return self;
}

- (void)fetchModelData:(void (^)(WModel *dataModel, NSMutableArray *dateList, NSMutableArray *lowTempList, NSMutableArray *highTempList, NSMutableArray *weatherDescription))callback {
    WProvider *pInstance = [[WProvider alloc] init];
    pInstance.cityName = self.cityInput;
    [pInstance fetchDataWithCallback:^(NSData *data, NSError *error) {
        WAdapter *aInstance = [[WAdapter alloc] init];
        WModel *finalModel = [aInstance convertDataToModel:data];
        NSDictionary *cellData = [aInstance dataForCells:finalModel];
        callback([finalModel copy], [cellData[@"dayName"] copy], [cellData[@"temp_max"] copy], [cellData[@"temp_min"] copy], [cellData[@"description"] copy]);
    }];
}



@end
