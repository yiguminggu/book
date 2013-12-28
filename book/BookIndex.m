//
//  BookIndex.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "BookIndex.h"

@implementation BookIndex
@synthesize indexid, title, parentid;

-(NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"BookIndex\nid is %i, \ntitle is %@, \nparentid is %i",indexid,title,parentid];
    return desc;
}
-(void) dealloc
{
    [title release];
    [super dealloc];
}


@end
