//
//  Model.m
//  ApiTest
//
//  Created by bl on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//


#import "Model.h"
#import "APIKey.h"


@implementation Model

@synthesize delegate;

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that uses a REST API to perform optical character recognition (OCR) on any
//  text that may be in the imageData parameter.
//
//  Documentation for the API can be found at
//  https://westus.dev.cognitive.microsoft.com/docs/services/56f91f2d778daf23d8ec6739/operations/56f91f2e778daf14a499e1fc
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) extractText: (NSString *) language
                from: (NSData *) imageData
{
    // Initialize the request
    NSString *urlString = [NSString stringWithFormat:@"https://westus.api.cognitive.microsoft.com/vision/v1.0/ocr?language=%@&detectOrientation=true", language];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = imageData;
    [request addValue:MICROSOFT_OCR_KEY forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    // Initialize a session for managing data transfer tasks
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Execute the request in the background
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                    NSString *errorMsg;
                    
                    // If there was a connectivity issues then ...
                    if (error)
                        // retrieve the error message
                        errorMsg = [error localizedDescription];

                    // If did not receive a HTTP response then ...
                    else if (![response isKindOfClass:[NSHTTPURLResponse class]])
                        // format an error message
                        errorMsg = @"Received an unknown response type from the server.";

                    // Otherwise, ...
                    else
                    {
                        NSDictionary *dataDictionary;
            
                        // Extract the status code from the HTTP response
                        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];

                        switch (statusCode)
                        {
                            // If the request was successful then ...
                            case 200:
                                // convert the retrieved JSON data into a dictionary
                                dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:kNilOptions
                                                                                   error:&error];
                                // If the JSON conversion did not failed then ...
                                if (!error)
                                {
                                    // reformat the dictionary
                                    NSString *detectedLanguage = dataDictionary[@"language"];
                                    NSString *text = [self getOCRText:dataDictionary];
                                    
                                    // Notify the delegate of the result
                                    dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       [self.delegate didExtractText:text
                                                                                  in:detectedLanguage];
                                                   });
                                    return;
                                }
                                // otherwise ...
                                else
                                    // retrieve the reason why the JSON conversion failed
                                    errorMsg = [error localizedDescription];
                                
                                break;
                            
                            // If the OCR failed then ...
                            case 400:
                            case 415:
                            case 500:
                                // convert the retrieved JSON data into a dictionary
                                dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:kNilOptions
                                                                                   error:&error];
                                // If the JSON conversion did not failed then ...
                                if (!error)
                                    // extract the error message from server
                                    errorMsg = dataDictionary[@"message"];
                                // otherwise ...
                                else
                                    // retrieve the reason why the JSON conversion failed
                                    errorMsg = [error localizedDescription];

                                break;
                                
                            default:
                                errorMsg = [NSString stringWithFormat:@"Unexpected status code: %ld", (long) statusCode];
                                break;
                        }
                    }
                            
                    // Notify the delegate about the error
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       [self.delegate didGetModelError:errorMsg];
                                   });
                }
      ] resume];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to return a list of langauge
//
//  List of language supported by Microsoft
//    unk (AutoDetect)                  -  not supported by Yandex
//    zh-Hans (ChineseSimplified)       -  not supported by Yandex
//    zh-Hant (ChineseTraditional)      -  not supported by Yandex
//    cs (Czech)
//    da (Danish)
//    nl (Dutch)
//    en (English)
//    fi (Finnish)
//    fr (French)
//    de (German)
//    el (Greek)
//    hu (Hungarian)
//    it (Italian)
//    Ja (Japanese)                     -  not supported by Yandex
//    ko (Korean)                       -  not supported by Yandex
//    nb (Norwegian)                    -  not supported by Yandex
//    pl (Polish)
//    pt (Portuguese,
//    ru (Russian)
//    es (Spanish)
//    sv (Swedish)
//    tr (Turkish)
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary *) getLanguages
{
    return [[NSDictionary alloc] initWithObjectsAndKeys:
                @"cs", @"Czech",
                @"da", @"Danish",
                @"nl", @"Dutch",
                @"en", @"English",
                @"fi", @"Finnish",
                @"fr", @"French",
                @"de", @"German",
                @"el", @"Greek",
                @"hu", @"Hungarian",
                @"it", @"Italian",
                @"pl", @"Polish",
                @"pt", @"Portuguese",
                @"ru", @"Russian",
                @"es", @"Spanish",
                @"sv", @"Swedish",
                @"tr", @"Turkish",
                nil
            ];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that uses a REST API to translate text from one language to another.
//
//  Documentation for the API can be found at
//  https://tech.yandex.com/translate/doc/dg/reference/translate-docpage/
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) translateText: (NSString *) text
                  from: (NSString *) sourceLanguage
                    to: (NSString *) targetLanguage
{
    // Initialize the request
    NSString *encodedText = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"https://translate.yandex.net/api/v1.5/tr.json/translate?lang=%@-%@&key=%@&text=%@", sourceLanguage, targetLanguage, YANDEX_KEY, encodedText];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Initialize a session for managing data transfer tasks
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Execute the request in the background
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          NSString *errorMsg;
          
          // If there was a connectivity issues then ...
          if (error)
              // retrieve the error message
              errorMsg = [error localizedDescription];
          
          // If did not receive a HTTP response then ...
          else if (![response isKindOfClass:[NSHTTPURLResponse class]])
              // format an error message
              errorMsg = @"Received an unknown response type from the server.";
          
          // Otherwise, ...
          else
          {
              NSDictionary *dataDictionary;
              
              // Extract the status code from the HTTP response
              NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
              
              switch (statusCode)
              {
                      // If the request was successful then ...
                  case 200:
                      // convert the retrieved JSON data into a dictionary
                      dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&error];
                      // If the JSON conversion did not failed then ...
                      if (!error)
                      {
                          NSArray *textArray = dataDictionary[@"text"];
                          
                          // Notify the delegate of the result
                          dispatch_async(dispatch_get_main_queue(),
                                         ^{
                                             [self.delegate didTranslateText:(NSString *) textArray[0]];
                                         });
                          return;
                      }
                      // otherwise ...
                      else
                          // retrieve the reason why the JSON conversion failed
                          errorMsg = [error localizedDescription];
                      
                      break;
                      
                      // If the translation failed then ...
                  case 401:
                      errorMsg = @"Invalid API key";
                      break;
                      
                  case 402:
                      errorMsg = @"Blocked API key";
                      break;
                      
                  case 404:
                      errorMsg = @"Exceeded the daily limit on the amount of translated text";
                      break;
                      
                  case 413:
                      errorMsg = @"Exceeded the maximum text size";
                      break;
                      
                  case 422:
                      errorMsg = @"The text cannot be translated";
                      break;
                      
                  case 501:
                      errorMsg = @"The specified translation direction is not supported";
                      break;
                      
                  default:
                      errorMsg = [NSString stringWithFormat:@"Unexpected status code: %ld", (long) statusCode];
                      break;
              }
          }
          
          // Notify the delegate about the error
          dispatch_async(dispatch_get_main_queue(),
                         ^{
                             [self.delegate didGetModelError:errorMsg];
                         });
      }
    ] resume];
}


#pragma mark - Private Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to extract the OCR text from the dictionary.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) getOCRText: (NSDictionary *) dataDictionary
{
    NSMutableString *str = [NSMutableString string];
    NSArray *regions = dataDictionary[@"regions"];

    for (int i = 0; i < regions.count; ++i)
    {
        NSDictionary *insideRegionDictionary = (NSDictionary *)regions[i];
        NSArray *lines = insideRegionDictionary[@"lines"];
        
        for (int j = 0; j < lines.count; ++j)
        {
            NSDictionary *insideLineDictionary = (NSDictionary *)lines[j];
            NSArray *words = insideLineDictionary[@"words"];
            
            for (int k = 0; k < words.count; ++k)
            {
                NSDictionary *insideWordDictionary = (NSDictionary *)words[k];
                
                // If this not first word of the line then ...
                if (k)
                    // include a blank space before the word
                    [str appendFormat:@" %@", insideWordDictionary[@"text"]];
                // otherwise, ...
                else
                    // just append the word
                    [str appendString:insideWordDictionary[@"text"]];
            }
            
            // Append new line character
            [str appendString:@"\n"];
        }
    }
    
    return str;
}

@end
