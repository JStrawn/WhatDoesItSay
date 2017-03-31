//
//  SettingsViewController.h
//  ApiTest
//
//  Created by Miguel Tepale on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface SettingsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>


@property (strong, nonatomic) IBOutlet UIPickerView *sourcePickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *targetPickerView;

@property (strong, nonatomic) Settings *settings;

- (void)saveLanguageSetting;

@end
