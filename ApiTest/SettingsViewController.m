//
//  SettingsViewController.m
//  ApiTest
//
//  Created by Miguel Tepale on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveLanguageSetting)];
    self.navigationItem.leftBarButtonItem = saveButton;
}

- (void)saveLanguageSetting {
    
    //Before popping, the data from the UIPickerView must be saved
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
