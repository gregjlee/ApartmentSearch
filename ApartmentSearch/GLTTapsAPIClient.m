//
//  GLTTapsAPIClient.m
//  MapTest
//
//  Created by Gregory Lee on 7/3/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import "GLTTapsAPIClient.h"
#import "AFJSONRequestOperation.h"
//http://api.3taps.com/search?auth_token=faded8a41a3665016df30cc42e1afb66&source=CRAIG
static NSString * const kTTapsAPIBaseURLString = @"http://search.3taps.com";
static NSString * const kAPIKey = @"faded8a41a3665016df30cc42e1afb66";
static const NSString * THREETAPS_API_BASE_URL = @"http://api.3taps.com";
@implementation GLTTapsAPIClient
+ (GLTTapsAPIClient *)sharedClient {
    static GLTTapsAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kTTapsAPIBaseURLString]];
        //lat=34.025612&long=-118.297008&radius=10.2mi
        _sharedClient.latitude=34.025612;
        _sharedClient.longitude=-118.297008;
        _sharedClient.radius=10.2;
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    return self;
}
+(NSMutableDictionary *)paramsWithDefaults{
    NSString *retVals=@"id,price,location,heading,images,body";
    NSString *radiusString = [NSString stringWithFormat:@"%fmi",[self sharedClient].radius];
    NSDictionary *params = @{@"auth_token": kAPIKey,@"source":@"CRAIG", @"category":@"RHFR", @"retvals":retVals, @"lat":[NSNumber numberWithFloat:[self sharedClient].latitude], @"long":[NSNumber numberWithFloat:[self sharedClient].longitude], @"radius":radiusString };
    NSLog(@"params %@",params);
    return [NSMutableDictionary dictionaryWithDictionary:params];
}

+ (void)getEndPoint:(NSString *)endPoint block:(void (^)(NSArray  *results))block{
    NSMutableDictionary *params=[self paramsWithDefaults];
    NSLog(@"get end point lat %f long %f",[self sharedClient].latitude, [self sharedClient].longitude);
    [[self sharedClient] getPath:endPoint
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             NSArray* data = [responseObject objectForKey:@"postings"];
                             if (data) {
                                 if (block) {
                                     block(data);
                                 }
                             }
                             else{
                                 NSLog(@"null data");
                             }
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"error: %@", error.localizedDescription);
                         }];
}

@end
