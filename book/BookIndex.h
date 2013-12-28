//
//  BookIndex.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookIndex : NSObject
//目录id
@property(nonatomic) NSUInteger  indexid;
//目录名称
@property(nonatomic,copy) NSString *title;
//父目录id
@property(nonatomic) NSUInteger parentid;

@end
