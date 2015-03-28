//
//  HomeViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "HomeViewController.h"
#import "REFrostedViewController.h"
@interface HomeViewController ()<MKMapViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Map View
    [self.mapview addAnnotations:[self annotations]];
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:3];
    
    // Annotations
}
-(void)zoomInToMyLocation
{
    
//    NSString* longitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"longitude"];
//    NSString* latitude = [[NSUserDefaults standardUserDefaults] stringForKey:@"latitude"];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = 21.0018385 ;
    region.center.longitude = 105.80524481;
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    [self.mapview setRegion:region animated:YES];
}
- (NSArray *)annotations {
    
    // Empire State Building
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"pinMap.png"];
    empire.coordinate = CLLocationCoordinate2DMake(21.0016279f, 105.8049829f);
    empire.disclosureBlock =  ^{
        [UIView animateWithDuration:1
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             CGRect f = self.ViewDetail.frame;
                             f.origin.y = 428; // new y
                             self.ViewDetail.frame = f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    };
    
    JPSThumbnail *empire2 = [[JPSThumbnail alloc] init];
    empire2.image = [UIImage imageNamed:@"pinMap.png"];
    empire2.coordinate = CLLocationCoordinate2DMake(21.0036279f, 105.8049829f);
    empire2.disclosureBlock =  ^{
        [UIView animateWithDuration:1
                              delay:0
                            options: UIViewAnimationCurveEaseOut
                         animations:^{
                             CGRect f = self.ViewDetail.frame;
                             f.origin.y = 428; // new y
                             self.ViewDetail.frame = f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    };
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire],[JPSThumbnailAnnotation annotationWithThumbnail:empire2]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
        
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
@end
