//
//  PostDetailViewController.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;
@class PostDetailView;
@interface PostDetailViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property(nonatomic,strong)Post *post;
@property(strong,nonatomic)PostDetailView *postDetailView;
@end
