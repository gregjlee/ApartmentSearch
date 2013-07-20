//
//  MapViewController.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/17/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import "ChildVCProtocol.h"
@class MapViewController;
@class Post;

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,weak)id<ChildVCProtocol>delegate;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSMutableArray *posts;
@property (nonatomic,strong)CLLocationManager *locManager;
-(void)removeCalloutView;
@end
