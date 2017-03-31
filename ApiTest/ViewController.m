//
//  ViewController.m
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import "ViewController.h"
#import "ImageProcessor.h"


@interface ViewController ()

@end

@implementation ViewController
{
    ImageProcessor *_imageProcessor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //If no camera, show alert
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self noCamera];
    }
    
    //Setting "items" in UINavagationBar
    self.title = @"What does it say?";
    
    //Do not erase - Miguel
//    UIColor *navBarCustomColor = [UIColor alloc]initWithRed:242.0 green:231.0 blue:248.0 alpha:1.0
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(goToSettingsVC)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    UIBarButtonItem *resultsButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(goToResultsVC)];
    self.navigationItem.rightBarButtonItem = resultsButton;
    
    self.resultsViewController = [[ResultsViewController alloc] init];

    _imageProcessor = [ImageProcessor sharedInstance];
    _imageProcessor.mainViewController = self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.imageView.image = nil;
}

- (void)goToSettingsVC {
    
    self.settingsViewController = [[SettingsViewController alloc]init];
    self.settingsViewController.title = @"Settings";
    [self.navigationController pushViewController:self.settingsViewController animated:YES];
}

- (void)goToResultsVC {
    
    self.resultsViewController.title = @"Translation";
    //self.imageView.image = self.resultsViewController.
    [self.navigationController pushViewController:self.resultsViewController animated:YES];
}


- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(selectedImage, 0.5);
    [_imageProcessor processImage:imageData];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void) noCamera {
    UIAlertController * alert= [UIAlertController
                                  alertControllerWithTitle:@"Error!"
                                  message:@"Your device does not have a camera!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method for displaying an error message.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) displayError:(NSString *)errorMsg
{
    // Initialize the controller for displaying the message
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
                                                                   message:errorMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // Create an OK button
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    // Add the button to the controller
    [alert addAction:okButton];
    
    // Display the alert controller on the topmost viewController
    UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [navigationController.topViewController presentViewController:alert animated:YES completion:nil];
}

@end
