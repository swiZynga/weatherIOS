//
//  WModel.m
//  Weather
//
//  Created by Sangwook Wi on 5/3/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "WModel.h"
#import "WCenter.h"


@implementation WModel 

- (id)copyWithZone:(NSZone *)zone
{
    WModel *newWModel = [[[self class] allocWithZone:zone] init];
    newWModel.days = self.days;
    
    return newWModel;
}

- (void) updateModel:(NSMutableArray *) data
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:@"0"];
    
    WDayModel *day1 = [[WDayModel alloc] initWithdayName:[data[0] valueForKey:@"day"] weatherDesc:[data[0] valueForKey:@"description"] highTemp:[fmt stringFromNumber:[data[0] valueForKey:@"high"]] lowTemp:[fmt stringFromNumber:[data[0] valueForKey:@"low"]] currTemp:[fmt stringFromNumber:[data[0] valueForKey:@"current"]] city:[data[0] valueForKey:@"city"]];
    
    WDayModel *day2 = [[WDayModel alloc] initWithdayName:[data[1] valueForKey:@"day"] weatherDesc:[data[1] valueForKey:@"description"] highTemp:[fmt stringFromNumber:[data[1] valueForKey:@"high"]] lowTemp:[fmt stringFromNumber:[data[1] valueForKey:@"low"]] currTemp:@"0" city:[data[0] valueForKey:@"city"]];

    WDayModel *day3 = [[WDayModel alloc] initWithdayName:[data[2] valueForKey:@"day"] weatherDesc:[data[2] valueForKey:@"description"] highTemp:[fmt stringFromNumber:[data[2] valueForKey:@"high"]] lowTemp:[fmt stringFromNumber:[data[2] valueForKey:@"low"]] currTemp:@"0"city:[data[0] valueForKey:@"city"]];

    WDayModel *day4 = [[WDayModel alloc] initWithdayName:[data[3] valueForKey:@"day"] weatherDesc:[data[3] valueForKey:@"description"] highTemp:[fmt stringFromNumber:[data[3] valueForKey:@"high"]] lowTemp:[fmt stringFromNumber:[data[3] valueForKey:@"low"]] currTemp:@"0"city:[data[0] valueForKey:@"city"]];

    WDayModel *day5 = [[WDayModel alloc] initWithdayName:[data[4] valueForKey:@"day"] weatherDesc:[data[4] valueForKey:@"description"] highTemp:[fmt stringFromNumber:[data[4] valueForKey:@"high"]] lowTemp:[fmt stringFromNumber:[data[4] valueForKey:@"low"]] currTemp:@"0"city:[data[0] valueForKey:@"city"]];

    _days = @[day1, day2, day3, day4, day5];
}

@end
