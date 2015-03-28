//
//  HomeViewController.h
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JPSThumbnailAnnotation.h"

@interface HomeViewController : UIViewController<CLLocationManagerDelegate>
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIView *ViewDetail;

@end
