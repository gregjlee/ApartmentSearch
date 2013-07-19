//
//  PostAnnotationView.m
//  ApartmentFinder
//
//  Created by Gregory Lee on 7/17/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "PostAnnotationView.h"

@implementation PostAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.enabled = YES;
        //            annotationView.canShowCallout = YES;
        self.image = [UIImage imageNamed:@"pinGreen.png"];
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        CGSize size=self.bounds.size;
        CGRect labelFrame=CGRectMake(2, 2, size.width-2, size.height*.75);
        [_priceLabel removeFromSuperview];
        _priceLabel=[[UILabel alloc]initWithFrame:labelFrame];
        [_priceLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        _priceLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:_priceLabel];

        
    }
    return self;
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
