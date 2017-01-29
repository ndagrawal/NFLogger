//
//  NFNetworkManager.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^UploadCompletionBlock)(NSData *data);

@interface NFNetworkManager : NSObject

-(void)uploadAllEvents:(NSDictionary *)data withCompletionBlock:(UploadCompletionBlock)completionBlock;

@end
