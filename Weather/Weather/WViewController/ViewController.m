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
}

@property(strong, nonatomic) NSMutableArray *daysCell;
@property(strong, nonatomic) NSMutableArray *highTempCell;
@property(strong, nonatomic) NSMutableArray *lowTempCell;
@property(strong, nonatomic) NSMutableArray *weatherCell;

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
    [cInstance fetchModelData:^(WModel *dataModel, NSMutableArray* dayCellData, NSMutableArray* highTempCellData, NSMutableArray* lowTempCelldata, NSMutableArray* weatherDescriptionCellData) {
        [self update:dataModel with:dayCellData and:highTempCellData and:lowTempCelldata and:weatherDescriptionCellData];
    }];
    
}

- (void)update:(WModel *)data with:(NSMutableArray *)dayCellData and:(NSMutableArray *)highTempCellData and:(NSMutableArray *)lowTempCelldata and:(NSMutableArray *)weatherDescriptionCellData {
    NSArray *dayModel = data.days;
    WDayModel *dayOne = [dayModel objectAtIndex:0];
    self.curWeather.text = [dayOne weather];
    self.curTemp.text = [dayOne current];
    self.todayDay.text = [dayOne name];
    self.todayLow.text = [dayOne low];
    self.todayHigh.text = [dayOne high];
    self.city.text = [dayOne cityName];
    _daysCell = dayCellData;
    _highTempCell = highTempCellData;
    _lowTempCell = lowTempCelldata;
    _weatherCell = weatherDescriptionCellData;
    [self setWeatherImage:[dayOne weather] with:[NSNumber numberWithInteger:1]];
    [_WTableView reloadData];
}

-(void)setWeatherImage:(NSString *)weather with:(NSNumber *)index {
    if([weather isEqualToString: @"clear sky"]){
        if ([index isEqualToNumber:[NSNumber numberWithInteger: 1]]) {
            [_wImage1 setImage:[UIImage imageNamed:@"sunny"]];
    } else {
        if ([index isEqualToNumber:[NSNumber numberWithInteger: 1]]) {
            [_wImage1 setImage:[UIImage imageNamed:@"rain"]];
            }
        }
    }
}

- (void)hide {
    _WTableView.hidden = true;
    _cancelBtn.hidden = false;
    _locationTextField.hidden = false;
}

- (void)unhide {
    _WTableView.hidden = false;
    _cancelBtn.hidden = true;
    _locationTextField.hidden = true;
}

- (void)hideSearchBar {
    if (!locationViewOpened) {
        originalsize = CGRectMake(_locationView.frame.origin.x, _locationView.frame.origin.y, _locationView.frame.size.width, _locationView.frame.size.height);
        [UIView transitionWithView:_locationView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            _locationView.frame = CGRectMake(0, _divider.frame.origin.y, _locationView.frame.size.width, _locationView.frame.origin.y - _divider.frame.origin.y + _locationView.frame.size.height);
                            _locationView.alpha = 0.8;
                            _locationView.backgroundColor = [UIColor blackColor];
                            [self hide];
                        }
                        completion:nil];
        locationViewOpened = true;
    } else {
        [UIView transitionWithView:_locationView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            _locationView.frame = originalsize;
                            _locationView.alpha = 0.5;
                            _locationView.backgroundColor = [UIColor whiteColor];
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
    [_locationTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [_setLocation sendActionsForControlEvents:UIControlEventTouchUpInside];
    cInstance.cityInput = textField.text;
    [cInstance fetchModelData:^(WModel *dataModel, NSMutableArray* dayCellData, NSMutableArray* highTempCellData, NSMutableArray* lowTempCelldata, NSMutableArray* weatherDescriptionCellData) {
        [self update:dataModel with:dayCellData and:highTempCellData and:lowTempCelldata and:weatherDescriptionCellData];
    }];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_daysCell count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"WCell";
    WTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[WTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.dayName.text = [_daysCell objectAtIndex:indexPath.row];
    cell.lowTemp.text = [_lowTempCell objectAtIndex:indexPath.row];
    cell.highTemp.text = [_highTempCell objectAtIndex:indexPath.row];
    if ([[_weatherCell objectAtIndex:indexPath.row] isEqualToString:@"clear sky"]) {
        [cell.weatherImage setImage:[UIImage imageNamed:@"sunny"]];
    } else {
        [cell.weatherImage setImage:[UIImage imageNamed:@"rain"]];
    }
    
    return cell;
}



@end
