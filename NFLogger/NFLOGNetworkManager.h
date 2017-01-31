//
//  NFNetworkManager.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UploadCompletionBlock)(BOOL uploadSuccess);
/*!
    @brief Class handles responsibility of handling network calls.
 */
@interface NFLOGNetworkManager : NSObject
/*!
    @brief UploadEvents
    @param data data to be uploaded in NSDictionary Format.. 
    @param completionBlock to send status to user..
 
 */
+(void)uploadAllEvents:(NSDictionary *)data withCompletionBlock:(UploadCompletionBlock)completionBlock;

@end
