//
//  Settings.m
//  ApiTest
//
//  Created by Emiko Clark on 3/31/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import "Settings.h"

@implementation Settings

-(id)init {
    if ( self = [super init] ) {
        [self checkLanguageSettings];
    }
    return self;
}

- (void) save {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //save source and target language from UIPickerView to nsuserdefaults
    [defaults setObject: self.sourceLanguage forKey:@"sourceLanguage"];
    [defaults setObject: self.targetLanguage forKey:@"targetLanguage"];
    NSLog(@"Settings Saved1: source language:%@, target language:%@",self.sourceLanguage, self.targetLanguage);
}
-(void) checkLanguageSettings {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.sourceLanguage  =[defaults objectForKey:@"sourceLanguage" ];
    
    
    if (self.sourceLanguage == nil) {
        self.sourceLanguage = @"unk";
    }
    
    self.targetLanguage  =[defaults objectForKey:@"targetLanguage" ];
    
    if (self.targetLanguage == nil) {
        self.targetLanguage = [self setPreferredLanguage];
    }
    NSLog(@"Settings Saved: source language:%@, target language:%@",self.sourceLanguage, self.targetLanguage);
}

-(NSString *)setPreferredLanguage { //as written text
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray *preferredLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString *preferredLanguageCode = [preferredLanguages objectAtIndex:0]; //preferred device language code
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"]; //language name will be in English (or whatever)
    NSString *languageName = [enLocale displayNameForKey:NSLocaleIdentifier value:preferredLanguageCode]; //name of language, eg. "French"
    
    NSLog(@"preferredLanguages: %@, enLocale:%@, LanguageName:%@",preferredLanguages,enLocale,languageName);
    NSArray *languageTemp = [languageName componentsSeparatedByString:@" "];
    languageName = languageTemp[0];
    
    return languageName;
//    return [preferredLanguageCode substringWithRange:NSMakeRange(0, 2)];
}


@end
