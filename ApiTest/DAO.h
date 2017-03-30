//
//  DAO.h
//  ApiTest
//
//  Created by Juliana Strawn on 3/30/17.
//  Copyright © 2017 JStrawn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject

+ (void)sendToVisionAPI: (NSData*) imageData;

@end
