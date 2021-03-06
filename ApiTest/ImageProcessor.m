//
//  ImageProcessor.m
//  ApiTest
//
//  Created by bl on 3/31/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//


#import "ImageProcessor.h"


static Model *_model;
static NSDictionary *_languageDictionary;
static Settings *_settings;


@implementation ImageProcessor

#pragma mark - Public Properties

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Implements getter method for settings property.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (Settings *) settings
{
    return _settings;
}

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
                      _model.delegate = _sharedInstance;
                      
                      _settings = [[Settings alloc] init];
                      _languageDictionary = [_model getLanguages];
                      NSArray *keys = [_languageDictionary allKeys];
                      _settings.sourceLanguagesList = [keys sortedArrayUsingSelector:@selector(compare:)];
                      _settings.targetLanguagesList = _settings.sourceLanguagesList;
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
    // Send the image for OCR processing
    [_model extractText:_languageDictionary[_settings.sourceLanguage] from:imageData];
    
    [self.mainViewController goToResultsVC];
}

#pragma mark - Model Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model object when OCR has completed.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didExtractText: (NSString *) text in: (NSString *) displayLanguage
{
    // If text was found in the image then ...
    if (text.length != 0)
    {
        // Send the extracted text for translation
        [_model translateText:text
                         from:displayLanguage
                           to:_languageDictionary[_settings.targetLanguage]];

        // Display the extracted text in the resultsViewController
        self.mainViewController.resultsViewController.originalEmbededLabel.text = text;
    }
    // Otherwise, ...
    else
    {
        // Display an informational message
        self.mainViewController.resultsViewController.originalEmbededLabel.text = @"No text could be found in photo";
        
        [self.mainViewController.resultsViewController.translatedTextActivityIndicator stopAnimating];
        [self.mainViewController.resultsViewController.translatedTextActivityIndicator setHidden:YES];
    }
    
    [self.mainViewController.resultsViewController.originalTextActivityIndicator stopAnimating];
    [self.mainViewController.resultsViewController.originalTextActivityIndicator setHidden:YES];
}


//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model when an error occurred during image processing.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didGetModelError: (NSString *) errorMsg
{
    // stop activity indicator
    [self.mainViewController.resultsViewController.originalTextActivityIndicator stopAnimating];
    [self.mainViewController.resultsViewController.originalTextActivityIndicator setHidden:YES];
    [self.mainViewController.resultsViewController.translatedTextActivityIndicator stopAnimating];
    [self.mainViewController.resultsViewController.translatedTextActivityIndicator setHidden:YES];

    [self.mainViewController displayError:errorMsg];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the model object when the translation has completed.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didTranslateText: (NSString *) translatedText
{
    // Display the translated text in the resultsViewController
    self.mainViewController.resultsViewController.translatedEmbededLabel.text = translatedText;
    
    // stop activity indicator
    [self.mainViewController.resultsViewController.translatedTextActivityIndicator stopAnimating];
    [self.mainViewController.resultsViewController.translatedTextActivityIndicator setHidden:YES];
}

@end
