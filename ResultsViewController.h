//
//  ResultsViewController.h
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pictureThumbnail;
@property (strong, nonatomic)UIImage *pushedImage;
@property (weak, nonatomic) IBOutlet UILabel *originalEmbededLabel;
@property (weak, nonatomic) IBOutlet UILabel *translatedEmbededLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *originalTextActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *translatedTextActivityIndicator;

@end
