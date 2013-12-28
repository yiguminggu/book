//
//  ViewController.m
//  book
//
//  Created by 谷 铭 on 13-12-28.
//  Copyright (c) 2013年 com.example. All rights reserved.
//

#import "ViewController.h"
#import "BookDB.h"
#import "BookIndex.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize bookIndexes,bookIndexTable;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (self.bookIndexes == nil) {
        self.bookIndexes =[NSMutableArray array];
    }
    else
    {
        [self.bookIndexes removeAllObjects];
    }
    self.bookIndexes =  [BookDB fetchBookIndexes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//释放内存
/*-(void) delloc
{
    [bookIndexTable release];
    [bookIndexes release];
    [super delloc];
}
 */
#pragma mark - UITableViewDataSourse Methods
//Table的行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bookIndexes count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIndentifier =@"BookIndexView";
    UITableViewCell *cell = [bookIndexTable dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier]autorelease];
        //自动换行
        [cell.textLabel setNumberOfLines:0];
    }
    BookIndex *index = [self.bookIndexes objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[index title]];
     return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70;
}
#pragma mark - UITableViewDelegate Methods
//点击目录
//-(void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{

//}

- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.bookContentViewController == nil)
    {
        self.bookContentViewController = [[[BookContentViewController alloc] initWithNibName:@"BookContentViewController" bundle:nil] autorelease];
    }
    
    BookIndex *index = [self.bookIndexes objectAtIndex:indexPath.row];
	NSLog(@"%d", [index indexid]);
    
    [self.bookContentViewController setIndexid:[index indexid]];
    
    [self presentModalViewController:self.bookContentViewController animated:YES];
}
@end
