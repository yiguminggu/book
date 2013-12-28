//
//  BookContentViewController.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "BookContentViewController.h"
#import "BookDB.h"
#import "BookIndex.h"
#import "BookContent.h"

@interface BookContentViewController ()

@end

@implementation BookContentViewController
@synthesize indexTitleLabel,bookContentTextView,backToIndexButton;
@synthesize indexid;
//点击按钮返回目录列表
- (IBAction) backToIndex:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.backToIndexButton setTitle:NSLocalizedString(@"btn.backtoindex.title", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - view Lifecycle
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BookContent *content = [BookDB fetchBookContent:self.indexid];
    [self.bookContentTextView setText:[content contenttext]];
    [self.indexTitleLabel setText:[[content bookIndex] title]];
    [content release];
    [self.backToIndexButton setTitle:NSLocalizedString(@"btn.backtoindex.title", nil) forState:UIControlStateNormal];
}

-(void)dealloc
{
    [indexTitleLabel release];
    [bookContentTextView release];
    [backToIndexButton release];
    
    [super dealloc];
}




@end
