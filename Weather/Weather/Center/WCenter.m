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

@implementation WCenter


- (void)modelFromData: (void (^)(WModel *dataModel))callback
{
    WProvider *pInstance = [[WProvider alloc] init];
    [pInstance fetchDataWithCallback:^(NSData *data, NSError *error) {
        WAdapter *aInstance = [[WAdapter alloc] init];
        WModel *finalModel = [aInstance convertDataToModel:data];
        callback([finalModel copy]);
    }];
}



@end
