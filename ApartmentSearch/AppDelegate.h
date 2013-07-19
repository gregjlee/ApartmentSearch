//
//  AppDelegate.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/16/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainContainerViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainContainerViewController *viewController;
@property(nonatomic,strong)UINavigationController *navController;

@end
