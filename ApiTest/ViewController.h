//
//  ViewController.h
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "ResultsViewController.h"
#import "SettingsViewController.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) DAO *sharedManager;
@property (retain, nonatomic) ResultsViewController *resultsViewController;
@property (retain, nonatomic) SettingsViewController *settingsViewController;

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

@end

