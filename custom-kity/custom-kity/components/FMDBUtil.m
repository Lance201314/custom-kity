//
//  FMDBUtil.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/6.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "FMDBUtil.h"

@interface FMDBUtil ()
{
    FMDatabaseQueue *_queue;
}

@end

@implementation FMDBUtil

- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = [self checkDataBaseWithName:@"user.db"];
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    
    return self;
}

+ (instancetype)shareInstance
{
    static dispatch_once_t predicate = 0;
    __strong static FMDBUtil *_shareInstance;
    dispatch_once(&predicate, ^{
        if (_shareInstance == nil) {
            _shareInstance = [[[self class] alloc] init];
        }
    });
    
    return _shareInstance;
}

- (void)inDatabase:(void (^)(FMDatabase *db))block
{
    [_queue inDatabase:^(FMDatabase *db) {
        block(db);
    }];
}

- (void)inTransaction:(void (^)(FMDatabase *db, BOOL *rollback))block
{
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        block(db, rollback);
    }];
}

- (NSString *)checkDataBaseWithName:(NSString *)dbName
{
    NSString *documentDic = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDic stringByAppendingPathComponent:dbName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test_user.db"];
        if ([fileManager fileExistsAtPath:sourcePath]) {
            [fileManager copyItemAtPath:sourcePath toPath:path error:&error];
            if (error) {
                NSLog(@"copy database eror %@", error);
            }
        } else {
            NSLog(@"resouce do not have a db file");
        }
    }
    
    NSLog(@"path is %@", path);
    return path;
}

@end
