//
//  WTableViewCell.h
//  Weather
//
//  Created by Sangwook Wi on 5/4/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTableViewCell : UITableViewCell

@property(weak, nonatomic) IBOutlet UILabel *dayName;
@property(weak, nonatomic) IBOutlet UILabel *lowTemp;
@property(weak, nonatomic) IBOutlet UILabel *highTemp;
@property(weak, nonatomic) IBOutlet UIImageView *weatherImage;

@end
