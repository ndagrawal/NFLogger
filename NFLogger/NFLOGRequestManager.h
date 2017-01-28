//
//  NFLOGRequestManager.h
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/26/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFLOGEvent.h"
#import "NFLog.h"

typedef NFLOGRecordStatus (^RequestCompletionBlock) (BOOL sucess);
typedef void (^TableCreateCompletionBlock)(BOOL success);

@interface NFLOGRequestManager : NSObject


@property NSInteger uploadInterval;

+(id)sharedInstance;

#pragma mark - Database Related Methods.
-(void)createTableforEventType:(NSString *)eventType withCompletionBlock:(TableCreateCompletionBlock) completionBlock;
-(void)record:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock;
-(void)update:(NFLOGEvent *)event withCompletionBlock:(RequestCompletionBlock) completionBlock;
-(void)uploadAndDelete;

#pragma mark - Timer Based Methods.
-(void)validateTimer;
-(void)stopTimer;

@end
