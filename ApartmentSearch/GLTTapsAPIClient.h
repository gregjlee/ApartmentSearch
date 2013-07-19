//
//  GLTTapsAPIClient.h
//  MapTest
//
//  Created by Gregory Lee on 7/3/13.
//  Copyright (c) 2013 Gregory Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"

@interface GLTTapsAPIClient : AFHTTPClient
@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;
@property (nonatomic,assign)CGFloat radius;
+ (GLTTapsAPIClient *)sharedClient;
+ (void)getEndPoint:(NSString *)endPoint block:(void (^)(NSArray  *results))block;
@end
