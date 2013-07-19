//
//  Post.h
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/17/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Post : NSObject
-(id)initWithData:(NSDictionary *)data;
@property(nonatomic,strong)NSMutableArray *imageURLs;
@property(nonatomic,strong)NSString *heading;
@property(nonatomic,strong)NSString *body;
@property(nonatomic,strong)NSString *formattedAddress;
@property(nonatomic,assign)NSInteger price;
@property(nonatomic,assign)NSInteger postID;
@property(nonatomic,assign)CLLocationCoordinate2D coordinate;
-(NSString*)priceString;
@end
