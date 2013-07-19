//
//  PostDetailView.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/19/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "PostDetailView.h"
#import "Post.h";
#import <AFNetworking.h>
@implementation PostDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)configureWithPost:(Post *)post{
    _priceLabel.text=post.priceString;
    _bodyTextView.text=post.body;
    _headerLabel.text=post.heading;
    _addressLabel.text=post.formattedAddress;
    int i=0;
    CGSize size=_scrollView.bounds.size;
    _scrollView.contentSize=CGSizeMake(size.width*post.imageURLs.count, size.height);
    UIImage *placeHolder = [UIImage imageNamed:@"albumPlaceHolder.jpeg"];
    for (NSString *imageURL in post.imageURLs) {
        CGRect imageFrame=CGRectOffset(_scrollView.bounds, i*size.width, 0);
        UIImageView *pageImageView=[[UIImageView alloc]initWithFrame:imageFrame];
        [pageImageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeHolder];
        [_scrollView addSubview:pageImageView];
        i++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
