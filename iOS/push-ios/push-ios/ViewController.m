//
//  ViewController.m
//  push-ios
//
//  Created by Enosis on 5/7/15.
//  Copyright (c) 2015 Enosis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // This get's the number you sent in the push and update your app badge.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
