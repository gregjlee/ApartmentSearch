//
//  PostMapAnnotation.h
//  ApartmentFinder
//
//  Created by Gregory Lee on 7/9/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface PostMapAnnotation : NSObject <MKAnnotation>
@property(nonatomic,assign)NSInteger index;
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate index:(NSInteger)indexPath;
- (MKMapItem*)mapItem;
@end
