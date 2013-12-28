//
//  BookDB.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookContent;
@interface BookDB : NSObject
//释放资源
+(void) finalizeStatements;
//打开数据库（单例）
+(id)singleton;
//获取图书目录索引的数量,用于TableViewController
+(NSInteger) fetchBookIndexCount;
//获取图书目录索引
+(NSMutableArray *) fetchBookIndexes;
//获取正文内容
+(BookContent *) fetchBookContent:(NSUInteger) indexid;
@end
