//
//  unity.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/22/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "unity.h"

#define URL_SIGNIN @"http://localhost:8080/TN/restServices/riderController/Login"
#define UPDATE_URL @"http://localhost:8080/TN/restServices/riderController/UpdateRider"
#define NEAR_TAXI_URL @"http://localhost:8080/TN/restServices/DriverController/getNearDriver"
#define FIND_PROMOTION_TRIP_URL @"http://localhost:8080/TN/restServices/PromotionTripController/FindPromotionTip"
#define CREATETRIP @"http://localhost:8080/TN/restServices/TripController/CreateTrip"


@implementation unity

+(void)login_by_email:(NSString *)email pass:(NSString *)pass owner:(LoginViewController*)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    
    NSString *url=[NSString stringWithFormat:@"%@",URL_SIGNIN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"username":email, @"password":pass};
    
    [manager POST:url parameters:params2
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         model.dataUser=[NSDictionary dictionaryWithDictionary:responseObject];
         owner.dataUser=model.dataUser;
         [owner checkLogin];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];

     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@""
                                                          message:NSLocalizedString(@"please check info login",nil)
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                                otherButtonTitles:nil, nil];
         [alertTmp show];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"offLoginloading" object:self];
     }];
}
+(void)register_by_email : (NSString*)email password:(NSString *)pass firstname:(NSString *)firstname lastname:(NSString *)lastname phone:(NSString *)phone language:(NSString *)language usergroup:(NSString *)usergroup countrycode:(NSString *)countrycode
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSString *api=[NSString stringWithFormat:@"http://localhost:8080/TN/restServices/CommonController/register?email=%@&password=%@&firstname=%@&lastname=%@&phone=%@&language=%@&usergroup=%@&countrycode=%@",email,pass,firstname,lastname,phone,language,usergroup,countrycode];
    NSLog(@"api:%@",api);

    [manager GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+(void)updateByRiderById:(NSString *)riderId firstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email phoneNo:(NSString *)phoneNo
{
    NSString *url=[NSString stringWithFormat:@"%@",UPDATE_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params2 = @ {@"id":riderId, @"firstname":firstName, @"lastname":lastName, @"phoneNumber":phoneNo, @"email":email};
    [manager POST:url
       parameters:params2  success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           
       }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertTmp =[[UIAlertView alloc]initWithTitle:@"LỖI"
                                                               message:NSLocalizedString(@"Cap nhat du lieu khong thanh cong ",nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Đồng ý",nil)
                                                     otherButtonTitles:nil, nil];
              [alertTmp show];
              
          }];
    
    
}

+(void)getNearTaxi:(NSString *)latitude andLongtitude:(NSString *)longtitude owner:(HomeViewController *)owner
{
    UserInfo *model = [[UserInfo alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@",NEAR_TAXI_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"latitude":latitude,@"longitude":longtitude};
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              model.neartaxi=(NSArray *)responseObject;
              owner.nearTaxi=model.neartaxi;
              [owner checkGetnearTaxi];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
          }];
}

+(void)findPromotionTrips:(NSString *)formLatitude
         andfromLongitude:(NSString *)fromLongitude
           withToLatitude:(NSString *)toLatitude
           andToLongitude:(NSString *)toLongitude
{
    NSString *url = [NSString stringWithFormat:@"%@",FIND_PROMOTION_TRIP_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{@"fromLatitude":fromLongitude, @"fromLongitude":fromLongitude, @"toLatitude":toLatitude, @"toLongitude":toLongitude};
    [manager POST:url parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {

          }];
}
+(void)CreateTrip:(NSString*)param owner:(DetailTaxi *)owner
{
    NSString *url = [NSString stringWithFormat:@"%@",CREATETRIP];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url
       parameters:param
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"success");

          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"failse");

          }];
}


@end
