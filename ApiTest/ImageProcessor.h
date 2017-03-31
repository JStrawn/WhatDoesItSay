//
//  ImageProcessor.h
//  ApiTest
//
//  Created by bl on 3/31/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Model.h"
#import "ViewController.h"


@interface ImageProcessor : NSObject<ModelDelegate>

@property (atomic, strong) ViewController *mainViewController;

+ (ImageProcessor *) sharedInstance;

- (void) processImage: (NSData *) imageData;

@end
