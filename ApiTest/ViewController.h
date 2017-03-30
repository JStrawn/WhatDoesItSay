//
//  ViewController.h
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) DAO *sharedManager;

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)setLanguageButtonWasPressed:(id)sender;
- (IBAction)submitPhotoButtonWasPressed:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *setLanguageButton;
@property (weak, nonatomic) IBOutlet UIButton *submitPhotoButton;


@end

