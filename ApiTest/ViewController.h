//
//  ViewController.h
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsViewController.h"
#import "SettingsViewController.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) ResultsViewController *resultsViewController;
@property (retain, nonatomic) SettingsViewController *settingsViewController;
@property (strong, nonatomic) UIImage *photo;
@property (weak, nonatomic) IBOutlet UILabel *sourceAndTargetLabel;

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

- (void) displayError: (NSString *) errorMsg;
- (void) goToResultsVC;

@end

