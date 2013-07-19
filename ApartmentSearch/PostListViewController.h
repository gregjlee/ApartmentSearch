//
//  PostListViewController.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/18/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildVCProtocol.h"
@class PostListViewController;
@class Post;
@interface PostListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)id<ChildVCProtocol>delegate;
@property (nonatomic,strong) NSMutableArray *posts;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
