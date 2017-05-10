//
//  ViewController.h
//  Weather
//
//  Created by Sangwook Wi on 5/2/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UILabel *city;
@property(weak, nonatomic) IBOutlet UILabel *curWeather;
@property(weak, nonatomic) IBOutlet UILabel *curTemp;
@property(weak, nonatomic) IBOutlet UILabel *todayDay;
@property(weak, nonatomic) IBOutlet UILabel *todayHigh;
@property(weak, nonatomic) IBOutlet UILabel *todayLow;
@property(weak, nonatomic) IBOutlet UIImageView *wImage1;
@property(weak, nonatomic) IBOutlet UIView *locationView;
@property(weak, nonatomic) IBOutlet UITextField *locationTextField;
@property(weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property(weak, nonatomic) IBOutlet UIButton *setLocation;
@property(weak, nonatomic) IBOutlet UITableView *WTableView;
@property(weak, nonatomic) IBOutlet UIImageView *divider;


@end

