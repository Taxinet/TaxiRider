//
//  unity.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "HomeViewController.h"
#import "DetailTaxi.h"
@class HomeViewController;
@class DetailTaxi;
@interface unity : NSObject

+(void)login_by_email : (NSString*)email pass:(NSString *)pass owner:(LoginViewController*)owner;
+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode;

+(void)updateByRiderById : (NSString*)riderId
                firstName:(NSString*)firstName
                 lastName:(NSString*)lastName
                    email:(NSString*)email
                  phoneNo:(NSString*)phoneNo;

+(void)getNearTaxi:(NSString*)latitude
     andLongtitude:(NSString*)longtitude owner:(HomeViewController *)owner;

+(void)findPromotionTrips : (NSString*)formLatitude
          andfromLongitude: (NSString*)fromLongitude
            withToLatitude: (NSString*)toLatitude
            andToLongitude: (NSString*)toLongitude ;

+(void)CreateTrip:(NSString*)param owner:(DetailTaxi *)owner;
@end
