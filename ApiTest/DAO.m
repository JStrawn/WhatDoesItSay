//
//  DAO.m
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import "DAO.h"
#import "ResultsViewController.h"

@implementation DAO

+ (id)sharedManager {
    static DAO *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


+ (void)sendToVisionAPI: (NSData*) imageData{
    
    NSString *myKey = @"5bcdbb3baaf449e2b449dc7eb7743b45";
    
    //Bobby & Emi - this needs to be NoT hard coded
    NSString *currentLanguage = @"en";
    
    //[self.activityIndicator startAnimating];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSString *urlString = [NSString stringWithFormat: @"https://westus.api.cognitive.microsoft.com/vision/v1.0/ocr?language=%@&detectOrientation=true", currentLanguage];
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = imageData;
    [request addValue:myKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //[self.activityIndicator stopAnimating];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"WHAT WE GOT BACK: %@", jsonDictionary);
        
        //UIViewController *vC = [[ResultsViewController alloc]init];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //vC.dictToParse = jsonDictionary;
            
            //NSLog(@"OBJ TO FIND: %@", self.cVC.itemToFind);
            
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"downloadDataComplete" object:nil];
        });
        
        
        
    }
      ]resume];
}


@end

