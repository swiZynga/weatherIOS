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

- (void)fetchModelData:(void (^)(WModel *dataModel))callback {
    WProvider *pInstance = [[WProvider alloc] init];
    pInstance.cityName = self.cityInput;
    [pInstance fetchDataWithCallback:^(NSData *data, NSError *error) {
        WAdapter *aInstance = [[WAdapter alloc] init];
        WModel *finalModel = [aInstance convertDataToModel:data];
        
        callback([finalModel copy]);
    }];
}



@end
