//
//  MapViewController.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/17/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "MapViewController.h"
#import "PostListViewController.h"
#import "PostMapAnnotation.h"
#import "PostAnnotationView.h"
#import "GLTTapsAPIClient.h"
#import "Post.h"
#import "CalloutView.h"
#import <AFNetworking.h>
#define METERS_PER_MILE 1609.344
#define MILES_PER_DEGREE 69
#define START_RADIUS 2
#define SCROLL_UPDATE_DISTANCE  1.2
@interface MapViewController (){
    CLLocationCoordinate2D lastLocationCoordinate;
}


@end

@implementation MapViewController

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
    _locManager = [[CLLocationManager alloc] init];
    [_locManager setDelegate:self];
    [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self configureNavButtons];
       // Do any additional setup after loading the view from its nib.
}
-(void)configureNavButtons{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"list" style:UIBarButtonItemStyleBordered target:self action:@selector(listTapped:)];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [_locManager startMonitoringSignificantLocationChanges];
}
-(void)refetchDataBlock:(void (^)(NSArray  *results))block{
    [self updateClientMapSearchWithRegion:[self.mapView region]];
    _posts = [[NSMutableArray alloc]init];
    [GLTTapsAPIClient getEndPoint:nil block:^(NSArray *results) {
        for (NSDictionary *data in results) {
            Post *post=[[Post alloc]initWithData:data];
//            NSLog(@"post lat %f long %f",post.coordinate.latitude,post.coordinate.longitude);
            [_posts addObject:post];
        }
        if (block) {
            block(results);
        }
    }];
}
-(void)updateClientMapSearchWithRegion:(MKCoordinateRegion)mapRegion{
    MKCoordinateSpan span = mapRegion.span;
    CLLocationCoordinate2D centerLocation = mapRegion.center;
    [GLTTapsAPIClient sharedClient].radius=span.latitudeDelta*MILES_PER_DEGREE;
    [GLTTapsAPIClient sharedClient].latitude=centerLocation.latitude;
    [GLTTapsAPIClient sharedClient].longitude=centerLocation.longitude;
//    lastLocationCoordinate.latitude=centerLocation.latitude;
//    lastLocationCoordinate.longitude=centerLocation.longitude;

}
#pragma mark location manager delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(manager.location.coordinate, 0.5*METERS_PER_MILE, START_RADIUS*METERS_PER_MILE);
    NSLog(@"locManager updated and stopped %f %f",viewRegion.center.latitude,viewRegion.center.longitude);
    [self updateClientMapSearchWithRegion:viewRegion];
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    _posts = [[NSMutableArray alloc]init];
    [_locManager stopMonitoringSignificantLocationChanges];
    
    [GLTTapsAPIClient getEndPoint:nil block:^(NSArray *results) {
        for (NSDictionary *data in results) {
            Post *post=[[Post alloc]initWithData:data];
            [_posts addObject:post];
        }
     [self plotPositions];
    }];
}
-(CGFloat)getRadiusWithRegion:(MKCoordinateRegion)region{
    return region.span.latitudeDelta*MILES_PER_DEGREE;
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D currCoord=mapView.centerCoordinate;
    
    CLLocation *before = [[CLLocation alloc] initWithLatitude:lastLocationCoordinate.latitude longitude:lastLocationCoordinate.longitude];
    CLLocation *now = [[CLLocation alloc] initWithLatitude:currCoord.latitude longitude:currCoord.longitude];
    
    CLLocationDistance distance = ([before distanceFromLocation:now]) * 0.000621371192;
    
    
    CGFloat changeDistance = mapView.region.span.longitudeDelta*MILES_PER_DEGREE *.25;
    
    NSLog(@"currSPan %f %f ",distance ,changeDistance);
    if( distance > changeDistance)
    {
        [self removeCalloutView];
        NSLog(@"regionDidChangeAnimated");
        lastLocationCoordinate.latitude = currCoord.latitude;
        lastLocationCoordinate.longitude = currCoord.longitude;
        [self refetchDataBlock:^(NSArray *results) {
            [self plotPositions];
        }];
    }
    
    
    
}
-(void)removeCalloutView{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CalloutView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)plotPositions {
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        if (![annotation isEqual:_mapView.userLocation ]) {
            [_mapView removeAnnotation:annotation];
        }
    }
    for (int i=0;i<self.posts.count;i++) {
        Post *post=[self.posts objectAtIndex:i];
        NSLog(@"plot %f %f",post.coordinate.latitude,post.coordinate.longitude);
        PostMapAnnotation *annotation = [[PostMapAnnotation alloc] initWithName:@"dfd" address:@"afa" coordinate:post.coordinate index:i];
        [_mapView addAnnotation:annotation];
	}

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"PostMapAnnotation";
    
    if ([annotation isKindOfClass:[PostMapAnnotation class]]) {
        PostAnnotationView *annotationView = (PostAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[PostAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        PostMapAnnotation *postAnnotation=(PostMapAnnotation *)annotation;
        Post *post=[self.posts objectAtIndex:postAnnotation.index];
        annotationView.priceLabel.text=[NSString stringWithFormat:@"$%d",post.price];
        return annotationView;
    }
    return nil;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
        
        CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"CalloutView" owner:self options:nil] objectAtIndex:0];

        [calloutView.priceLabel setText:[(PostMapAnnotation*)[view annotation] title]];

        CGRect calloutFrame=calloutView.frame;
        CGSize callSize=calloutFrame.size;
        CGRect annotFrame=[view.superview convertRect:view.frame toView:self.view];
        calloutFrame.origin.x=15;
        calloutFrame.origin.y=annotFrame.origin.y-callSize.height;
        if (CGRectGetMinY(calloutFrame)-callSize.height<0) {
            calloutFrame.origin.y=CGRectGetMaxY(annotFrame);
        }
        calloutView.frame=calloutFrame;

        [self.view addSubview:calloutView];
        PostMapAnnotation *postAnnotation=(PostMapAnnotation*)view.annotation;
        Post *post=[self.posts objectAtIndex:postAnnotation.index];
        [self configureCalloutView:calloutView fromPost:post];
    }
    
}

-(void)configureCalloutView:(CalloutView *)calloutView fromPost:(Post*)post{
    calloutView.tag=[self.posts indexOfObject:post];
    calloutView.headingLabel.text=post.heading;
    calloutView.priceLabel.text=[NSString stringWithFormat:@"$%d",post.price];
    [calloutView.imageView setImageWithURL:[NSURL URLWithString:post.imageURLs[0]] placeholderImage:[UIImage imageNamed:@"albumPlaceHolder.jpeg"]];
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(calloutTapped:)];
    [calloutView addGestureRecognizer:gesture];
}

//12
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    for (UIView *subview in self.view.subviews ){
        if ([subview isKindOfClass:[CalloutView class]]) {
            [subview removeFromSuperview];
        }
    }
}
-(void)calloutTapped:(UITapGestureRecognizer*)gesture{
    if ([gesture.view isKindOfClass:[CalloutView class]]) {
        Post *post=[self.posts objectAtIndex:gesture.view.tag];
        [self.delegate childVC:self selectedPost:post];
    }
    
}
#pragma mark navbuttons
- (void)refreshTapped:(id)sender {
    NSLog(@"refresh tapped");
    [self refetchDataBlock:^(NSArray *results) {
        [self plotPositions];

    }];
    
}

-(void)listTapped{
    NSLog(@"list tapped");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
