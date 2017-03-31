//
//  ResultsViewController.m
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStyleDone target:self action:@selector(returnToMainVc)];
    self.navigationItem.leftBarButtonItem = cameraButton;
    
    self.pictureThumbnail.image = self.pushedImage;
    
    
    //self.originalTextActivityIndicator = [[UIActivityIndicatorView alloc]init];
    //self.translatedTextActivityIndicator = [[UIActivityIndicatorView alloc]init];
    
    [self.originalTextActivityIndicator startAnimating];
    [self.translatedTextActivityIndicator startAnimating];
    
}

- (void)returnToMainVc {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
