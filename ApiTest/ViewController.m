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
    
    // If no camera, show alert
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self displayError:@"Your device does not have a camera!"];
    }
    
    // Setting "items" in UINavagationBar
    self.title = @"";
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(goToSettingsVC)];
    self.navigationItem.leftBarButtonItem = settingsButton;
    
    self.resultsViewController = [[ResultsViewController alloc] init];

    _imageProcessor = [ImageProcessor sharedInstance];
    _imageProcessor.mainViewController = self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.imageView.image = nil;
    
    if ([_imageProcessor.settings.sourceLanguage isEqualToString:@"unk"])
               self.sourceAndTargetLabel.text = [NSString stringWithFormat: @"Language Setting: Auto Detect -> %@", _imageProcessor.settings.targetLanguage];
    
    else
        self.sourceAndTargetLabel.text = [NSString stringWithFormat: @"Language Setting: %@ -> %@", _imageProcessor.settings.sourceLanguage,_imageProcessor.settings.targetLanguage];
    
}

- (void)goToSettingsVC {
    
    self.settingsViewController = [[SettingsViewController alloc]init];
    self.settingsViewController.title = @"Settings";
    self.settingsViewController.settings = _imageProcessor.settings;
    [self.navigationController pushViewController:self.settingsViewController animated:YES];
}

- (void)goToResultsVC {
    
    self.resultsViewController.title = @"Translation";
    
    self.resultsViewController.pushedImage = self.photo;
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
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo = chosenImage;
    [_imageProcessor processImage:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
