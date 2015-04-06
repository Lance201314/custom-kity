//
//  ViewController.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+LLCustom.h"
#import "FMDBTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    [self test];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20.0, 100.0, 300.0, 60.0);
    [button setRoundButtonWithRadius:5];
    
    [button setTitle:@"test color" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
    
//    [self performSelector:@selector(test) withObject:nil afterDelay:0];
}

- (void)test
{
    NSDate *date = [NSDate date];
    FMDBTest *test = [[FMDBTest alloc] init];
    [test query];
    NSLog(@"end time: %f", [[NSDate date] timeIntervalSinceDate:date] * 1000);
}

- (IBAction)query:(id)sender {
    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(query) object:nil];
    [thread start];
}

- (void)query
{
    FMDBTest *test = [[FMDBTest alloc] init];
    [test update];
}

- (IBAction)insert:(id)sender {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(insert) object:nil];
    [thread start];
}

- (void)insert
{
    FMDBTest *test = [[FMDBTest alloc] init];
    [test deleteInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
