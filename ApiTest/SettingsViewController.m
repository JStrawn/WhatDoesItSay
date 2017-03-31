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
    
    // picker stuff    
    
    self.sourcePickerView.dataSource=self;
    self.targetPickerView.dataSource=self;
    self.sourcePickerView.delegate=self;
    self.targetPickerView.delegate=self;
    [self.sourcePickerView setShowsSelectionIndicator:YES];
    [self.targetPickerView setShowsSelectionIndicator:YES];
    [self.sourcePickerView reloadAllComponents];
    [self.targetPickerView reloadAllComponents];
}

#pragma mark language setting methods

- (void)saveLanguageSetting {
    
    [self.settings save];
    
    // pop view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}



#pragma mark pickerView Delegate methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if (pickerView == self.sourcePickerView) {
        self.settings.sourceLanguage = self.settings.sourceLanguagesList[row];
    }
    else if (pickerView == self.targetPickerView) {
        self.settings.targetLanguage = self.settings.targetLanguagesList[row];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.sourcePickerView) {
        // First Picker
        return self.settings.sourceLanguagesList.count;
    }
    NSAssert(pickerView == self.targetPickerView, @"Unknown pickerView");
    return self.settings.targetLanguagesList.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.sourcePickerView) {
        // First Picker
        return 1;
    }
    NSAssert(pickerView == self.targetPickerView, @"Unknown pickerView");
    return 1;
}


// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (pickerView == self.sourcePickerView) {
        return self.settings.sourceLanguagesList[row];
    }
    NSAssert(pickerView == self.targetPickerView, @"Unknown pickerView");
    return self.settings.targetLanguagesList[row];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
