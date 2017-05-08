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

@interface ViewController () {
    WCenter *cInstance;
    bool locationViewOpened;
    NSString *locationCity;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    SPINNER FOR LOADING
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    spinner.center = CGPointMake(160, 350);
//    spinner.tag = 1;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
    
    locationCity = @"";
    locationViewOpened = false;
    [self unhide];
    _locationTextField.returnKeyType = UIReturnKeyDone;
    [_locationTextField setDelegate:self];
    cInstance = [[WCenter alloc] init];
    [cInstance modelFromData:^(WModel *dataModel) {
        [self update:dataModel];
    }];
    
}

- (void)update: (WModel *)data {
    
    NSArray *dayModel = data.days;
    WDayModel *dayOne = [dayModel objectAtIndex:0];
    WDayModel *dayTwo = [dayModel objectAtIndex:1];
    WDayModel *dayThree = [dayModel objectAtIndex:2];
    WDayModel *dayFour = [dayModel objectAtIndex:3];
    WDayModel *dayFive = [dayModel objectAtIndex:4];
    
    self.curWeather.text = [dayOne getWeather];
    self.curTemp.text = [dayOne getCurrent];
    self.todayDay.text = [dayOne getName];
    self.todayLow.text = [dayOne getLow];
    self.todayHigh.text = [dayOne getHigh];
    self.city.text = [dayOne getCityName];
    
    self.day2.text = [dayTwo getName];
    self.day3.text = [dayThree getName];
    self.day4.text = [dayFour getName];
    self.day5.text = [dayFive getName];
    
    self.high2.text = [dayTwo getHigh];
    self.high3.text = [dayThree getHigh];
    self.high4.text = [dayFour getHigh];
    self.high5.text = [dayFive getHigh];

    self.low2.text = [dayTwo getLow];
    self.low3.text = [dayThree getLow];
    self.low4.text = [dayFour getLow];
    self.low5.text = [dayFive getLow];
    
    [self setWeatherImage:[dayOne getWeather] with:[NSNumber numberWithInteger:1]];
    [self setWeatherImage:[dayOne getWeather] with:[NSNumber numberWithInteger:2]];
    [self setWeatherImage:[dayOne getWeather] with:[NSNumber numberWithInteger:3]];
    [self setWeatherImage:[dayOne getWeather] with:[NSNumber numberWithInteger:4]];
    [self setWeatherImage:[dayOne getWeather] with:[NSNumber numberWithInteger:5]];
    
}

-(void)setWeatherImage: (NSString *)weather with:(NSNumber *)index
{
    if([weather isEqualToString: @"clear sky"]){
        if ([index isEqualToNumber:[NSNumber numberWithInteger: 1]]) {
            [_wImage1 setImage:[UIImage imageNamed:@"sunny"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:2]]) {
            [_wImage2 setImage:[UIImage imageNamed:@"sunny"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:3]]) {
            [_wImage3 setImage:[UIImage imageNamed:@"sunny"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:4]]) {
            [_wImage4 setImage:[UIImage imageNamed:@"sunny"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:5]]) {
            [_wImage5 setImage:[UIImage imageNamed:@"sunny"]];
        }
    } else {
        if ([index isEqualToNumber:[NSNumber numberWithInteger: 1]]) {
            [_wImage1 setImage:[UIImage imageNamed:@"rain"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:2]]) {
            [_wImage2 setImage:[UIImage imageNamed:@"rain"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:3]]) {
            [_wImage3 setImage:[UIImage imageNamed:@"rain"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:4]]) {
            [_wImage4 setImage:[UIImage imageNamed:@"sunny"]];
        } else if ([index isEqualToNumber:[NSNumber numberWithInteger:5]]) {
            [_wImage5 setImage:[UIImage imageNamed:@"rain"]];
        }
    }
}

- (void) hide
{
    _day2.hidden = true;
    _day3.hidden = true;
    _day4.hidden = true;
    _day5.hidden = true;
    _high2.hidden = true;
    _high3.hidden = true;
    _high4.hidden = true;
    _high5.hidden = true;
    _low2.hidden = true;
    _low3.hidden = true;
    _low4.hidden = true;
    _low5.hidden = true;
    _wImage2.hidden = true;
    _wImage3.hidden = true;
    _wImage4.hidden = true;
    _wImage5.hidden = true;
    _cancelBtn.hidden = false;
    _locationTextField.hidden = false;
}

- (void) unhide
{
    _day2.hidden = false;
    _day3.hidden = false;
    _day4.hidden = false;
    _day5.hidden = false;
    _high2.hidden = false;
    _high3.hidden = false;
    _high4.hidden = false;
    _high5.hidden = false;
    _low2.hidden = false;
    _low3.hidden = false;
    _low4.hidden = false;
    _low5.hidden = false;
    _wImage2.hidden = false;
    _wImage3.hidden = false;
    _wImage4.hidden = false;
    _wImage5.hidden = false;
    _cancelBtn.hidden = true;
    _locationTextField.hidden = true;
}

- (IBAction)setLocation:(id)sender
{

    if (!locationViewOpened) {
        [UIView transitionWithView:_locationView
                          duration:0.4
                           options:UIViewAnimationOptionTransitionNone
                        animations:^{
                            _locationView.frame = CGRectMake(0, 346, 375, 321);
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
                            _locationView.frame = CGRectMake(0, 613, 375, 54);
                            _locationView.alpha = 0.5;
                            _locationView.backgroundColor = [UIColor whiteColor];
                            [self unhide];
                        }
                        completion:nil];
        locationViewOpened = false;
    }
}

- (IBAction)cancelBtn:(id)sender
{
    [_setLocation sendActionsForControlEvents:UIControlEventTouchUpInside];
    [_locationTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [_setLocation sendActionsForControlEvents:UIControlEventTouchUpInside];
    locationCity = textField.text;
    cInstance = [[WCenter alloc] init];
    [cInstance modelFromData:^(WModel *dataModel) {
        [self update:dataModel];
    }];
    
    return YES;
}


- (void)cityUserInput: (void (^)(NSString *city))callback
{
    callback([locationCity copy]);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
