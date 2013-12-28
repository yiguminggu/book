//
//  BookContentViewController.h
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookContentViewController : UIViewController
//显示目录名称名称的Label
@property (nonatomic,retain) IBOutlet UILabel *indexTitleLabel;
//显示正文的TextView
@property (nonatomic,retain) IBOutlet UITextView *bookContentTextView;
//返回目录列表按钮
@property(nonatomic,retain) IBOutlet UIButton *backToIndexButton;
//图书正文对应的目录ID
@property (nonatomic) NSUInteger indexid;
//点击按钮返回目录列表
-(IBAction) backToIndex:(id)sender;
@end
