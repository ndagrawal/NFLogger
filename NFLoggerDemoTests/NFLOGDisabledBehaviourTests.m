//
//  NFLOGDisabledBehaviour.m
//  NFLogger
//
//  Created by Nilesh Agrawal on 1/28/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NFLogger.h"
#import "NFLOGDisabledBehaviour.h"

@interface NFLOGDisabledBehaviourTests : XCTestCase
@property NFLOGDisabledBehaviour *disabledBehaviour;
@end

@implementation NFLOGDisabledBehaviourTests
@synthesize disabledBehaviour = _disabledBehaviour;

- (void)setUp {
    [super setUp];
    _disabledBehaviour = [[NFLOGDisabledBehaviour alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Auto Behaviour
-(void)testAutoLogEventWithCompletionHandlerWithNilParameters{
    [_disabledBehaviour logEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
    }];
}

-(void)testAutoLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_disabledBehaviour logEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
        
    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithNilParameters{
    [_disabledBehaviour startActiveEvent:@"event" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
    }];
}


-(void)testStartActiveLogEventWithCompletionHandlerWithValidParameters{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"testObject1",@"key1",nil];
    [_disabledBehaviour startActiveEvent:@"event" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
    }];
}

-(void)testEndActiveLogEventWithEventWithValidEvent{
    [_disabledBehaviour endActiveEvent:@"event" completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
    }];
}

-(void)testEndActiveLogEventWithEventWithNilEvent{
    [_disabledBehaviour endActiveEvent:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            XCTAssertEqual(recordStatus,NFLOGDisabled);
        });
    }];
}

@end
