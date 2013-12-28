//
//  ViewController.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookContentViewController;
@interface ViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
//图书目录
@property (nonatomic,retain) NSMutableArray *bookIndexes;
//显示目录的Table View
@property (nonatomic,retain) IBOutlet UITableView *bookIndexTable;
@property (nonatomic,retain) BookContentViewController *bookContentViewController;
@end
