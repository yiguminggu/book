//
//  BookContent.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookIndex;
@interface BookContent : NSObject
//正文id
@property(nonatomic) NSUInteger contentid;
//正文内容
@property(nonatomic,copy) NSString *contenttext;
//目录
@property(nonatomic,retain) BookIndex *bookIndex;
@end
