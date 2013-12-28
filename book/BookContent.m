//
//  BookContent.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "BookContent.h"

@implementation BookContent
@synthesize contentid,contenttext,bookIndex;
-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"BookContent\nid is %i, \ntitle is %@, \nparentid is %@",contentid,contenttext,bookIndex];
    return desc;
}
-(void) dealloc
{
    [contenttext   release];
    [bookIndex release];
    [super dealloc];
}

@end
