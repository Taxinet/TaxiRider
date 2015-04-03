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
#import "UIViewController+CWPopup.h"

@interface HomeViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
- (IBAction)menu:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UIView *ViewDetail;

@property (weak, nonatomic) IBOutlet UILabel *mLocationTo;
@property (weak, nonatomic) IBOutlet UIImageView *mImageFocus;
@property (weak, nonatomic) IBOutlet UILabel *mLocationFrom;
@property (weak, nonatomic) IBOutlet UIView *viewLocationFrom;
@property (weak, nonatomic) IBOutlet UIView *viewLocationTo;
- (IBAction)findWay:(id)sender;
@end
