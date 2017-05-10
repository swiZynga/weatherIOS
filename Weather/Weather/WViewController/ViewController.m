//
//  ViewController.m
//  Weather
//
//  Created by Sangwook Wi on 5/2/17.
//  Copyright © 2017 Sangwook Wi. All rights reserved.
//

#import "ViewController.h"
#import "WModel.h"
#import "WCenter.h"
#import "WTableViewCell.h"

@interface ViewController() {
    WCenter *cInstance;
    CGRect originalsize;
    NSArray *dayModel;
}

@property(strong, nonatomic) NSMutableArray *daysCell;
@property(strong, nonatomic) NSMutableArray *highTempCell;
@property(strong, nonatomic) NSMutableArray *lowTempCell;
@property(strong, nonatomic) NSMutableArray *weatherCell;
@property(strong, nonatomic) WModel *cityModel;

@end

@implementation ViewController

bool locationViewOpened;


- (void)viewDidLoad {
    [super viewDidLoad];
    locationViewOpened = false;
    [self unhide];
    _locationTextField.returnKeyType = UIReturnKeyDone;
    [_locationTextField setDelegate:self];
    cInstance = [WCenter sharedInstance];
    [cInstance fetchModelData:^(WModel *dataModel) {
        [self update:dataModel];
    }];
    
}


- (void)update:(WModel *)data {
    
    self.cityModel = data;
    WDayModel *dayOne = [self.cityModel.days firstObject];
    self.curWeather.text = dayOne.weather;
    self.curTemp.text = dayOne.current;
    self.todayDay.text = dayOne.name;
    self.todayLow.text = dayOne.low;
    self.todayHigh.text = dayOne.high;
    self.city.text = self.cityModel.city;
    [self setWeatherImage:dayOne.weather forImageview:self.wImage1];
    [self.tableView reloadData];
}

-(void)setWeatherImage:(NSString *)weather forImageview:(UIImageView *)imageView {
    if([weather isEqualToString: @"clear sky"]){
        [imageView setImage:[UIImage imageNamed:@"sunny"]];
    } else {
        [imageView setImage:[UIImage imageNamed:@"rain"]];
    }
}

- (void)hide {
    self.tableView.hidden = true;
    self.cancelBtn.hidden = false;
    self.locationTextField.hidden = false;
}

- (void)unhide {
    self.tableView.hidden = false;
    self.cancelBtn.hidden = true;
    self.locationTextField.hidden = true;
}

- (void)hideSearchBar {
    if (!locationViewOpened) {
        originalsize = CGRectMake(self.locationView.frame.origin.x, self.locationView.frame.origin.y, self.locationView.frame.size.width, self.locationView.frame.size.height);
        [UIView transitionWithView:self.locationView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            self.locationView.frame = CGRectMake(0, self.divider.frame.origin.y, self.locationView.frame.size.width, self.locationView.frame.origin.y - self.divider.frame.origin.y + self.locationView.frame.size.height);
                            self.locationView.alpha = 0.8;
                            self.locationView.backgroundColor = [UIColor blackColor];
                            [self hide];
                        }
                        completion:nil];
        locationViewOpened = true;
    } else {
        [UIView transitionWithView:self.locationView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            self.locationView.frame = originalsize;
                            self.locationView.alpha = 0.5;
                            self.locationView.backgroundColor = [UIColor whiteColor];
                            [self unhide];
                        }
                        completion:nil];
        locationViewOpened = false;
    }
}

- (IBAction)setLocation:(id)sender {
    [self hideSearchBar];
}

- (IBAction)cancelBtn:(id)sender {
    [self hideSearchBar];
    [self.locationTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.setLocation sendActionsForControlEvents:UIControlEventTouchUpInside];
    cInstance.cityInput = textField.text;
    [cInstance fetchModelData:^(WModel *dataModel) {
        [self update:dataModel];
    }];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(0, [self.cityModel.days count] - 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"WCell";
    WTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[WTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSInteger index = indexPath.row + 1;
    WDayModel *day = self.cityModel.days[index];
    cell.dayName.text = day.name;
    cell.lowTemp.text = day.low;
    cell.highTemp.text = day.high;
    [self setWeatherImage:day.weather forImageview:cell.weatherImage];
    
    return cell;
}



@end
