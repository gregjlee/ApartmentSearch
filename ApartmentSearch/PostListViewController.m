//
//  PostListViewController.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/18/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "PostListViewController.h"
#import "ListViewCell.h"
#import "Post.h"
#import <AFNetworking.h>
@interface PostListViewController ()

@end

@implementation PostListViewController

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
}
-(void)didMoveToParentViewController:(UIViewController *)parent{
    [self.tableView reloadData];
    NSLog(@"postlist did move to parentvc");
}
-(void)willMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"postlist will move to par");
}
#pragma mark tableData
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ListViewCell" owner:nil options:nil];
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[ListViewCell class]])
            {
                cell = (ListViewCell *)currentObject;
                break;
            }
        }
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(ListViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Post *post=[self.posts objectAtIndex:indexPath.row];
    cell.headingLabel.text=post.heading;
    cell.priceLabel.text=[NSString stringWithFormat:@"$%d",post.price];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:post.imageURLs[0]] placeholderImage:[UIImage imageNamed:@"albumPlaceHolder.jpeg"]];
}

#pragma  mark table delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Post *post=[self.posts objectAtIndex:indexPath.row];
    [self.delegate childVC:self selectedPost:post];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
