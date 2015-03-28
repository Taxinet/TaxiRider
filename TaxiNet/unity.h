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
@interface unity : NSObject
//localhost:8080/TN/restServices/CommonController/register?email=123324d@gmail.com&password=123&firstname=truong&lastname=ha&phone=01234567889&&language=vi&usergroup=rd&countrycode=vn

+(void)login_by_email : (NSString*)email pass:(NSString *)pass owner:(LoginViewController*)owner;
+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode;

@end
