//
//  BookDB.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "BookDB.h"
#import "SQLiteHelper.h"
#import "BookIndex.h"
#import "BookContent.h"
@implementation BookDB
//数据库连接
static sqlite3 *kBookDatabase;
//SQLite 帮助类
static SQLiteHelper *kSqlite;
//目录数量
static sqlite3_stmt *fetchBookIndexCountStatement =nil;
//目录
static sqlite3_stmt *fetchBookIndexesStatement =nil;
//图书正文
static sqlite3_stmt *fetchBookContentStatement =nil;


//释放资源
+(void) finalizeStatements
{
    if (fetchBookIndexCountStatement) {
        sqlite3_finalize(fetchBookIndexCountStatement);
    }
    if (fetchBookIndexesStatement) {
        sqlite3_finalize(fetchBookIndexesStatement);
    }
    if (fetchBookContentStatement) {
        sqlite3_finalize(fetchBookContentStatement);
    }
    [kSqlite closeDatabase];
    
    
    
    
}
//打开数据库（单例）
+(id)singleton
{
    return [[[self alloc] init ]autorelease];
}




-(id)init
{
    if ((self = [super init]))
    {
        if (kBookDatabase ==nil)
        {
            if (kSqlite == nil)
            {
                kSqlite = [[SQLiteHelper alloc] init];
            }
            [kSqlite initDatabaseConnection];
            kBookDatabase =[kSqlite database];
        }
    }
    return self;
}




//获取图书目录索引的数量,用于TableViewController
+(NSInteger) fetchBookIndexCount
{
    if (fetchBookIndexCountStatement ==nil)
    {
        const char *sql = "SELECT COUNT(*) As total FROM book_index";
        if (sqlite3_prepare_v2(kBookDatabase, sql, -1, &fetchBookIndexCountStatement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(kBookDatabase));
        }
    }
    NSUInteger count = 0;
    if (sqlite3_step(fetchBookIndexCountStatement)==SQLITE_ROW)
    {
        count = sqlite3_column_int(fetchBookIndexCountStatement, 0);
    }
    return  count;
    
}
//获取图书目录索引
+(NSMutableArray *) fetchBookIndexes
{
    //编译sql查询
    if (fetchBookIndexesStatement == nil)
    {
        const char *sql = "SELECT * FROM book_index ORDER BY indexid ASC";
        if (sqlite3_prepare_v2(kBookDatabase, sql, -1, &fetchBookIndexesStatement, NULL) != SQLITE_OK ) {
            NSAssert1(0, @"Error: failed to prepare statement with message ' %s'.",
                      sqlite3_errmsg(kBookDatabase));
        }
    }
    NSMutableArray *indexes = [NSMutableArray array];
    while (sqlite3_step(fetchBookIndexesStatement) == SQLITE_ROW)
    {
        BookIndex *bookIndex = [[BookIndex alloc] init];
        bookIndex.indexid = sqlite3_column_int(fetchBookIndexesStatement, 0);
        bookIndex.title = [NSString stringWithUTF8String:(char *) sqlite3_column_text(fetchBookIndexesStatement, 1)];
        bookIndex.parentid = sqlite3_column_int(fetchBookIndexesStatement, 2);
        [indexes addObject:bookIndex];
        [bookIndex release];
    }
    //重置 statement  以便重用
    sqlite3_reset(fetchBookIndexesStatement);
    return indexes;
}
 

//获取正文内容
/*+(BookContent *) fetchBookContent:(NSInteger) indexid
{
    if (fetchBookContentStatement == nil) {
        const   char *sql = "SELECT c.contentid,c.countenttext,c.indexid,i.title FROM book_content c LEFT JOIN book_index i WHERE c.indexid = i.indexid AND c.indexid = ?";
        if (sqlite3_prepare_v2(kBookDatabase, sql, -1, &fetchBookContentStatement, NULL) !=SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message ' %s'.", sqlite3_errmsg(kBookDatabase));
        }
    }
    sqlite3_bind_int(fetchBookContentStatement, 1, indexid);
    BookContent *bookContent = [[BookContent alloc] init ];
    if (sqlite3_step(fetchBookContentStatement) == SQLITE_ROW) {
        bookContent.contentid = sqlite3_column_int(fetchBookContentStatement, 0);
        bookContent.contenttext = [NSString stringWithUTF8String:(char *) sqlite3_column_text(fetchBookContentStatement, 1)];
        BookIndex *bookIndex =[[BookIndex alloc] init ];
        bookIndex.indexid = sqlite3_column_int(fetchBookContentStatement, 2);
        bookIndex.title = [NSString stringWithUTF8String:(char *) sqlite3_column_text(fetchBookContentStatement, 3)];
        bookContent.bookIndex = bookIndex;
    }
    return bookContent;
}
 */
// 获取文章内容
+ (BookContent *) fetchBookContent: (NSUInteger)indexid
{
    if (fetchBookContentStatement == nil) {
		const char *sql = "SELECT c.contentid, c.contenttext, c.indexid, i.title FROM book_content c LEFT JOIN book_index i  WHERE c.indexid = i.indexid AND c.indexid = ?";
		if (sqlite3_prepare_v2(kBookDatabase, sql, -1, &fetchBookContentStatement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(kBookDatabase));
		}
	}
    sqlite3_bind_int(fetchBookContentStatement, 1, indexid);
    
	BookContent *bookContent = [[BookContent alloc] init];
    
	if (sqlite3_step(fetchBookContentStatement) == SQLITE_ROW)
	{
		bookContent.contentid = sqlite3_column_int(fetchBookContentStatement, 0);
        bookContent.contenttext = [NSString stringWithUTF8String:(char *)sqlite3_column_text(fetchBookContentStatement, 1)];
        
        BookIndex *bookIndex = [[BookIndex alloc] init];
        
        bookIndex.indexid = sqlite3_column_int(fetchBookContentStatement, 2);
        bookIndex.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(fetchBookContentStatement, 3)];
        bookContent.bookIndex = bookIndex;
        [bookIndex release];
	}
	
	// 重置 statement 以便重用
	sqlite3_reset(fetchBookContentStatement);
	
	return bookContent;
}
@end
