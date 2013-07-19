//
//  PostDetailView.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Post;
@interface PostDetailView : UIView
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UITextView *bodyTextView;
-(void)configureWithPost:(Post *)post;
@end
