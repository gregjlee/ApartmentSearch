//
//  PostDetailViewController.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "PostDetailViewController.h"
#import "Post.h"
#import "PostDetailView.h"
@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

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
    [self configurePostDetailView];
    [self configureContainerScrollView];
    // Do any additional setup after loading the view from its nib.
}
-(void)configureContainerScrollView{
    _containerScrollView.contentSize=_postDetailView.bounds.size;
}
-(void)configurePostDetailView{
    _postDetailView = (PostDetailView *)[[[NSBundle mainBundle] loadNibNamed:@"PostDetailView" owner:self options:nil] objectAtIndex:0];
    [_containerScrollView addSubview:_postDetailView];
    [_postDetailView configureWithPost:_post];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
