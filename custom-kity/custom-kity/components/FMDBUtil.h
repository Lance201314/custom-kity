//
//  FMDBUtil.h
//  custom-kity
//
//  Created by Lance Lan on 15/4/6.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface FMDBUtil : NSObject

+ (instancetype)shareInstance;
- (void)inDatabase:(void (^)(FMDatabase *db))block;
- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block;

@end
