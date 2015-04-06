//
//  FMDBTest.m
//  custom-kity
//
//  Created by Lance Lan on 15/4/6.
//  Copyright (c) 2015年 Lance Lan. All rights reserved.
//

#import "FMDBTest.h"
#import "FMDB.h"
#import "FMDBUtil.h"

@interface FMDBTest ()
{
    FMDatabaseQueue *_queue;
    
    NSUInteger _index;
}

@end

@implementation FMDBTest

- (void)testMulit
{
    _index = 0;
    
    NSMutableArray *threads = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(mulit) object:nil];
        [threads addObject:thread];
        
        [thread start];
    }
}

- (void)mulit
{
   [self insert];
}

- (void)insert
{ 
    FMDBUtil *util = [FMDBUtil shareInstance];
    [util inDatabase:^(FMDatabase *db) {
        for (int i = 0; i < 10; i ++) {
            [db executeUpdate:@"insert into users(name, nickname) values(?,?)", [NSString stringWithFormat:@"name %lu", _index], [NSString stringWithFormat:@"nickname %lu", _index]];
            _index ++;
            
            [NSThread sleepForTimeInterval:3];
        }
    }];
}

- (void)update
{
    FMDBUtil *util = [FMDBUtil shareInstance];
    [util inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (int i = 11; i <= 30; i ++) {
            [db executeUpdate:@"update users set nickname=? where uid=?", [NSString stringWithFormat:@"name %i aa", i], [NSString stringWithFormat:@"%i", i]];
            
            [NSThread sleepForTimeInterval:3];
            
            NSLog(@"update %d", i);
        }
    }];
}

- (void)deleteInfo
{
    FMDBUtil *util = [FMDBUtil shareInstance];
    [util inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (int i = 11; i <= 30; i ++) {
            [db executeUpdate:@"delete from users where uid=?", [NSString stringWithFormat:@"%i", i]];
            [NSThread sleepForTimeInterval:2];
            
            NSLog(@"delete %d", i);
        }
    }];
}

- (void)query
{
    NSString *path = [self checkDataBaseWithName:@"user.db"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from users"];
        while ([rs next]) {
            NSLog(@"uid-->%@, name-->%@", [rs objectForColumnName:@"uid"], [rs objectForColumnName:@"name"]);
        }
        [db close];
    }];
}

- (void)queryWithoutQueue
{
    NSString *path = [self checkDataBaseWithName:@"user.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    FMResultSet *rs = [db executeQuery:@"select * from users"];
    while ([rs next]) {
//        NSLog(@"uid-->%@, name-->%@", [rs objectForColumnName:@"uid"], [rs objectForColumnName:@"name"]);
    }
    [db close];
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
