//
//  main.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/4.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int a = (3);
        int b = (a);
        NSLog(@"%d", b);
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
