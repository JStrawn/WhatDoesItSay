//
//  Model.h
//  ApiTest
//
//  Created by bl on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol ModelDelegate <NSObject>

@required
- (void) didExtractText: (NSString *) text in: (NSString *) language;
- (void) didGetModelError: (NSString *) errorMsg;
- (void) didTranslateText: (NSString *) translatedText;

@end


@interface Model : NSObject

@property (nonatomic, assign) id <ModelDelegate> delegate;

- (void) extractText: (NSString *) language
                from: (NSData *) imageData;
- (NSDictionary *) getLanguages;
- (void) translateText: (NSString *) text
                  from: (NSString *) sourceLanguage
                    to: (NSString *) targetLanguage;

@end
