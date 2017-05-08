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

@property(nonatomic, strong) NSArray<WDayModel *> *days;
@property(nonatomic, strong) NSString *city;
- (void) updateModel:(NSMutableArray *) data;


@end
