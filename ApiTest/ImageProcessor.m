//
//  ImageProcessor.m
//  ApiTest
//
//  Created by bl on 3/31/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//


#import "ImageProcessor.h"


static Model *_model;
//static Settings *_settings;

@implementation ImageProcessor

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method implements the singleton pattern for this class.
//
//////////////////////////////////////////////////////////////////////////////////////////
+ (ImageProcessor *) sharedInstance
{
    static ImageProcessor *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,
                  ^{
                      _sharedInstance = [[ImageProcessor alloc] init];
                      
                      _model = [[Model alloc] init];
                      _model.delegate = self;
                      
//                      _settings = [[Settings alloc] init];
                  });
    
    return _sharedInstance;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method implements the singleton pattern for this class.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) processImage: (NSData *) imageData
{
//    [_model extractText:_settings.sourceLanguage from:imageData];
    
    // set resultsViewController thumbnail ???
    
    [self.mainViewController goToResultsVC];
    
    // start activity indicator ???
    //  [self.mainViewController.resultsViewController.activityIndicator startAnimating];
}

#pragma mark - Model Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model object when OCR has completed.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didExtractText: (NSString *) text in: (NSString *) displayLanguage
{
    // Load the extracted text into resultsViewController
    
    // Send the extracted text for translation
//    [_model translateText:text
//                     from:displayLanguage
//                       to:_settings.targetLanguage];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model when an error occurred during image processing.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didGetModelError: (NSString *) errorMsg
{
    [self.mainViewController displayError:errorMsg];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model object when the translation has completed.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didTranslateText: (NSString *) translatedText
{
    // load translated text into resultsViewController
    
    // stop activity indicator ???
    //  [self.mainViewController.resultsViewController.activityIndicator stopAnimating];
}

@end
