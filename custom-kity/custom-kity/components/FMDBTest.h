//
//  FMDBTest.h
//  custom-kity
//
//  Created by Lance Lan on 15/4/6.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTest : NSObject

- (void)testMulit;
- (void)query;
- (void)insert;
- (void)update;
- (void)deleteInfo:(NSUInteger)uid;

- (void)queryWithoutQueue;
- (void)insertWithoutQueue;
- (void)updateWithoutQueue;


@end
