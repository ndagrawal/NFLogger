//
//  ViewController.m
//  NFLoggerDemo
//
//  Created by Nilesh Agrawal on 1/27/17.
//  Copyright © 2017 Nilesh Agrawal. All rights reserved.
//

#import "ViewController.h"
#import "NFLog.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;

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
- (IBAction)buttonClicked:(id)sender {
    [NFLog logEvent:@"Sample Event"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"object1",@"key1", nil];
    [NFLog logEvent:@"Button Click" withParameters:dictionary];
    
    [NFLog logEvent:@"Sample Event 2" withParameters:nil completionBlock:^(NFLOGRecordStatus recordStatus) {
       dispatch_async(dispatch_get_main_queue(), ^{
          NSLog(@"Sample Sucess");
       });
    }];
    
}



@end
