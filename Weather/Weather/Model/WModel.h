//
//  WModel.h
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDayModel.h"

@interface WModel : NSObject <NSCopying>

@property(nonatomic, strong) NSMutableArray<WDayModel *> *days;
@property(nonatomic, strong, readonly) NSString *city;

@end
