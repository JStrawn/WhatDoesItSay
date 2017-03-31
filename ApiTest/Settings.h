//
//  Settings.h
//  ApiTest
//
//  Created by Emiko Clark on 3/31/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject 

@property (strong, nonatomic) NSArray *sourceLanguagesList;
@property (strong, nonatomic) NSArray *targetLanguagesList;

@property (strong, nonatomic)  NSString *targetLanguage;
@property (strong, nonatomic)  NSString *sourceLanguage;

- (void) save;

@end
