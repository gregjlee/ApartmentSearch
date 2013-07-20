//
//  MainContainerViewController.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/18/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "MainContainerViewController.h"
#import "PostListViewController.h"
#import "PostDetailViewController.h"
#import "MapViewController.h"
#import "FilterViewController.h"
@interface MainContainerViewController ()

@end

@implementation MainContainerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureNavButtons];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _childIndex=0;
    [self configureMapViewController];
    [self configurePostListViewController];
    _currentViewController=_mapViewController;
    [self.view addSubview:self.currentViewController.view];
    // Do any additional setup after loading the view from its nib.
}
-(void)configureMapViewController{
    _mapViewController=nil;
    _mapViewController= [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    _mapViewController.view.frame=self.view.bounds;
    [self addChildViewController:_mapViewController];
    _mapViewController.delegate=self;
}
-(void)configurePostListViewController{
    _postListViewController=nil;
    _postListViewController = [[PostListViewController alloc] initWithNibName:@"PostListViewController" bundle:nil] ;
    _postListViewController.view.frame= self.view.bounds;
    [self addChildViewController:_postListViewController];
    _postListViewController.delegate=self;

}
-(CGRect)getChildFrame{
    CGRect navFrame=self.navigationController.navigationBar.frame;
    return CGRectMake(0, CGRectGetMaxY(navFrame), CGRectGetMaxX(navFrame), self.view.bounds.size.height-navFrame.size.height);
}
-(void)configureNavButtons{
    NSString *rightTitle=([_currentViewController isKindOfClass:[MapViewController class]])?@"List":@"Map";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightTitle style:UIBarButtonItemStyleBordered target:self action:@selector(rightTapped:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"filters" style:UIBarButtonItemStyleBordered target:self action:@selector(leftTapped:)];
}

-(void)rightTapped:(id)sender{
    [self swapViewControllers];
//    [(MapViewController *)_currentViewController listTapped];
    
}

-(void)leftTapped:(id)sender{
    FilterViewController *filterVC=[[FilterViewController alloc]initWithNibName:@"FilterViewController" bundle:nil];
    [self presentViewController:filterVC animated:YES completion:^{
        
    }];
}
- (BOOL)shouldAutomaticallyForwardRotationMethods{
    return YES;
}
-(void)swapViewControllers{
    UIViewController *aNewViewController;
    BOOL isMap=[_currentViewController isKindOfClass:[MapViewController class]];
    NSString *buttonTitle;
    if (isMap) {
            _postListViewController.posts=_mapViewController.posts;
        aNewViewController=(UIViewController*)_postListViewController;
        buttonTitle=@"Map";
    }
    else{
        aNewViewController=(UIViewController*)_mapViewController;
        buttonTitle=@"List";
    }
    [aNewViewController.view layoutIfNeeded];
    
        
    __weak __block MainContainerViewController *weakSelf=self;
    [self transitionFromViewController:self.currentViewController
                      toViewController:aNewViewController
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:nil
                            completion:^(BOOL finished) {
                                self.navigationItem.rightBarButtonItem.title=buttonTitle;
                                [aNewViewController didMoveToParentViewController:weakSelf];
                                
                                weakSelf.currentViewController=aNewViewController;
                                if (isMap) {
                                    [_mapViewController removeCalloutView];
                                }
                            }];
}
#pragma mark mapDelegate
-(void)childVC:(UIViewController *)childVC selectedPost:(Post *)post{
    PostDetailViewController *postDetailVC=[[PostDetailViewController alloc]initWithNibName:@"PostDetailViewController" bundle:nil];
    postDetailVC.post=post;
    self.navigationItem.leftBarButtonItem.title=@"back";
    [self.navigationController pushViewController:postDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
