//
//  ChildVCProtocol.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Post;

@protocol ChildVCProtocol <NSObject>
-(void)childVC:(UIViewController*)childVC selectedPost:(Post*)post;
@end
