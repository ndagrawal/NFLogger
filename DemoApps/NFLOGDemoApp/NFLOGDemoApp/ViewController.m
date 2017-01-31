//
//  ViewController.m
//  NFLoggerDemo
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "ViewController.h"
#import <NFLogger/NFLogger.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UILabel *logEventLabel;
@property (weak, nonatomic) IBOutlet UILabel *startEventLabel;
@property (weak, nonatomic) IBOutlet UILabel *endEventLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logEvent:(id)sender {
    [NFLogger logEvent:@"Add To Cart"];
}

- (IBAction)logEventWithParam:(id)sender {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"100.0",@"item1",@"200.0",@"item2",nil];
    [NFLogger logEvent:@"Add To Cart With Items" withParameters:dictionary];
}

- (IBAction)logEventWithParamCompletionHandler:(id)sender {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"100.0",@"item1",@"200.0",@"item2",nil];
    [NFLogger logEvent:@"Complete Transaction" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(recordStatus == NFLOGEventRecorded){
                _logEventLabel.text = @"Recorded";
            }else{
                _logEventLabel.text = @"Not Recorded";
            }
        });
    }];
}

- (IBAction)startActiveEvent:(id)sender {
    [NFLogger startActiveEvent:@"StartTransaction"];
}
- (IBAction)endActiveEvent:(id)sender {
    [NFLogger endActiveEvent:@"StartTransaction"];
}

- (IBAction)startActiveEventWithParam:(id)sender {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"100.0",@"item1",@"200.0",@"item2",nil];
    [NFLogger startActiveEvent:@"StartAnotherTransaction" withParameters:dictionary];
}
- (IBAction)endActiveEventWithParam:(id)sender {
 
     [NFLogger endActiveEvent:@"StartAnotherTransaction"];
}

- (IBAction)startActiveEventWithCompletionHandler:(id)sender {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"100.0",@"item1",@"200.0",@"item2",nil];
    [NFLogger startActiveEvent:@"StartTransactionWithCompletion" withParameters:dictionary completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(recordStatus == NFLOGEventRecorded){
                _startEventLabel.text = @"Recorded";
            }else{
                _startEventLabel.text = @"Not Recorded";
            }
        });
    }];
}

- (IBAction)endActiveEventWithCompletionHandler:(id)sender {
    [NFLogger endActiveEvent:@"StartTransactionWithCompletion" completionBlock:^(NFLOGRecordStatus recordStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(recordStatus == NFLOGEventRecorded){
                _endEventLabel.text = @"Recorded";
            }else{
                _endEventLabel.text = @"Not Recorded";
            }
            });
        }];
}


@end
