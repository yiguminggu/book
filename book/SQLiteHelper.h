//
//  SQLiteHelper.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface SQLiteHelper : NSObject
{
    //数据库连接
    sqlite3 *database;
}
@property (nonatomic) sqlite3 *database;
//数据库文件路径
- (NSString *) sqliteDBFilePath;
//初始化数据库连接，打开连接，并返回数据库连接(存放在database中)
-(void) initDatabaseConnection;
//关闭数据库
-(void) closeDatabase;
@end


