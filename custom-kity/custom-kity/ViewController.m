//
//  ViewController.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+LLCustom.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20.0, 100.0, 300.0, 60.0);
    [button setRoundButtonWithRadius:5];
    
    [button setTitle:@"test color" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [button setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
