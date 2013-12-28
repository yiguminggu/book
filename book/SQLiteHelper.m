//
//  SQLiteHelper.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "SQLiteHelper.h"

@implementation SQLiteHelper
@synthesize database;
//数据库文件路径
- (NSString *) sqliteDBFilePath{
    return [[[NSBundle mainBundle] resourcePath]
            stringByAppendingPathComponent:@"example_book.sqlite3"];
}
//初始化数据库连接，打开连接，并返回数据库连接(存放在database中)
-(void) initDatabaseConnection{
    if (sqlite3_open([[self sqliteDBFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
}
//关闭数据库
-(void) closeDatabase{
    if (sqlite3_close(database) != SQLITE_OK) {
       NSAssert1(0, @"Error:failed to close database with message '%s'.", sqlite3_errmsg(database)); 
    }
    
}
@end
