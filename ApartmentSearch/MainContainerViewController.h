//
//  MainContainerViewController.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/18/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildVCProtocol.h"
@class  PostListViewController,MapViewController;
@interface MainContainerViewController : UIViewController<ChildVCProtocol>
@property (nonatomic,strong)UIViewController *currentViewController;
@property (nonatomic,strong)MapViewController *mapViewController;
@property (nonatomic,strong)PostListViewController *postListViewController;
@property (nonatomic,assign) NSInteger childIndex;
@end
