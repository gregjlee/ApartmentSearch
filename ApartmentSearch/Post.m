//
//  Post.m
//  ApartmentSearch
//
//  Created by Gregory Lee on 7/17/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "Post.h"

@implementation Post
-(id)initWithData:(NSDictionary *)data{
    self=[super init];
    if (self) {
        _heading=data[@"heading"];
        _body=data[@"body"];
        _postID=[data[@"id"]integerValue];
        _price=[data[@"price"]integerValue];
        
        NSDictionary *location=data[@"location"];
        _formattedAddress=location[@"formatted_address"];
        CLLocationCoordinate2D coord;
        coord.longitude=[location[@"long"] floatValue];
        coord.latitude = [location[@"lat"] floatValue];
        self.coordinate=coord;
        NSArray *imagesData=data[@"images"];
        if (imagesData.count>0) {
            _imageURLs=[[NSMutableArray alloc]init];
            for (NSDictionary *imageData in imagesData) {
                NSString *url=imageData[@"full"];
                [_imageURLs addObject:url];
            }
        }
    
        
        
    }
    return self;
}
-(NSString*)priceString{
    return [NSString stringWithFormat:@"$%d",_price];
}

/*
 
 {
 body = "CALL US FOR MORE INFORMATION - 877.338.1010 or visit www.1010wilshire.com";
 heading = "Upgrade your success here at TENTEN - call Milton";
 id = 449550987;
 images =         (
 {
 full = "http://images.craigslist.org/00p0p_818T96F6UW2_600x450.jpg";
 },
 {
 full = "http://images.craigslist.org/00K0K_9xEjsv9BdcI_600x450.jpg";
 },
 {
 full = "http://images.craigslist.org/00Y0Y_3Icsgnf28K3_600x450.jpg";
 },
 {
 full = "http://images.craigslist.org/00p0p_818T96F6UW2_600x450.jpg";
 },
 {
 full = "http://i1198.photobucket.com/albums/aa454/miltonocampo/TENTEN%20Wilshire%20Craigslist%20Ads/Suite15-Work.jpg";
 },
 {
 full = "http://i1198.photobucket.com/albums/aa454/miltonocampo/TENTEN%20Wilshire%20Craigslist%20Ads/ConferenceRoom.jpg";
 }
 );
 location =         {
 accuracy = 1;
 city = "USA-LAX-LSN";
 country = USA;
 county = "USA-CA-LOS";
 "formatted_address" = "1010 Wilshire Blvd, St. Paul, Los Angeles, CA";
 lat = "34.051652";
 locality = "USA-LAX-WSA";
 long = "-118.261656";
 metro = "USA-LAX";
 region = "USA-LAX-CEN";
 state = "USA-CA";
 zipcode = "USA-90017";
 };
 price = 4512;
 }
 */
@end
