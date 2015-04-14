//
//  HomeViewController.m
//  TaxiNet
//
//  Created by Louis Nhat on 3/6/15.
//  Copyright (c) 2015 Louis Nhat. All rights reserved.
//

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "REFrostedViewController.h"

@interface HomeViewController () {
    CLLocationCoordinate2D coordinateFrom;
    CLLocationCoordinate2D coordinateTo;
    MKPlacemark *placeFrom, *placeTo;
    int locationTabPosition;
    UITapGestureRecognizer *gestureFrom, *gestureTo;
    MKRoute *routeDetails;
    UITableView *mTableViewSuggest;
    NSMutableArray *arrDataSearched;
    
}


@property (nonatomic, strong) MKLocalSearch *localSearch;

@end

@implementation HomeViewController


@synthesize mLocationFrom,mLocationTo,mImageFocus,mapview,viewLocationFrom,viewLocationTo,mSearchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mSearchBar.delegate = self;
    arrDataSearched = [[NSMutableArray alloc] init];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    mTableViewSuggest = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mSearchBar.frame.origin.y + self.mSearchBar.frame.size.height, screenWidth, 0)];
    mTableViewSuggest.delegate = self;
    mTableViewSuggest.dataSource = self;
    
    [self.view addSubview:mTableViewSuggest];
    [mTableViewSuggest setHidden:YES];
    mTableViewSuggest.backgroundColor =[UIColor colorWithRed:.1 green:.1 blue:.1 alpha: .4];
    
    
    //set anchor point focus point
    mImageFocus.layer.anchorPoint = CGPointMake(0.5, 1.0);
    mapview.delegate = self;

    
    // Map View
//    [self.mapview addAnnotations:[self annotations]];
    [self performSelector:@selector(zoomInToMyLocation)
               withObject:nil
               afterDelay:1];
    
    gestureFrom = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(selectLocationFrom:)];
    [self.viewLocationFrom addGestureRecognizer:gestureFrom];
    
    gestureTo = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(selectLocationTo:)];
    [self.viewLocationTo addGestureRecognizer:gestureTo];
    
    [self selectLocationFrom:gestureFrom];
    [self.viewLocationFrom setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                             green:142.0f/255.0f
                                                              blue:209.0f/255.0f
                                                             alpha:1.0f]];
    
    [self.viewLocationTo setBackgroundColor:[UIColor colorWithRed:84.0f/255.0f
                                                              green:142.0f/255.0f
                                                               blue:209.0f/255.0f
                                                              alpha:1.0f]];
    
//    [UIView animateWithDuration:.7
//                     animations:^{
//                         //what you would like to animate
//                         
//                     }completion:^(BOOL finished){
//                         //do something when the animation finishes
//                     }];
//    MKCoordinateRegion region = _destinationRegion;
//    MKMapRect rect = MKMapRectForCoordinateRegion(_destinationRegion);
//    MKMapRect intersection = MKMapRectIntersection(rect, _mapView.visibleMapRect);
//    if (MKMapRectIsNull(intersection)) {
//        rect = MKMapRectUnion(rect, _mapView.visibleMapRect);
//        region = MKCoordinateRegionForMapRect(rect);
//        _intermediateAnimation = YES;
//    }
//    [_mapView setRegion:region animated:YES];
}

//-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    if (_intermediateAnimation) {
//        _intermediateAnimation = NO;
//        [_mapView setRegion:_destinationRegion animated:YES];
//    }
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrDataSearched count];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    MKMapItem *entity = [arrDataSearched objectAtIndex:indexPath.row];
    cell.textLabel.text = entity.placemark.title;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [mTableViewSuggest.layer addAnimation:animation forKey:nil];
    [mTableViewSuggest setHidden:NO];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [mTableViewSuggest.layer addAnimation:animation forKey:nil];
    [mTableViewSuggest setHidden:YES];
    [arrDataSearched removeAllObjects];
//    CGRect bounds = mTableViewSuggest.frame;
//    bounds.size.height=[arrDataSearched count]*20;
//    mTableViewSuggest.frame=bounds;

    [mTableViewSuggest reloadData];
    
    searchBar.text = @"";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (self.localSearch.searching)
    {
        [self.localSearch cancel];
    }
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = searchText;
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error)
    {
        if (error != nil)
        {
            NSLog(@"Could not find places");
        }
        else
        {
            [arrDataSearched addObjectsFromArray:[response mapItems]];
            CGRect bounds = [mTableViewSuggest bounds];
            [mTableViewSuggest setBounds:CGRectMake(bounds.origin.x,
                                            bounds.origin.y,
                                            bounds.size.width,
                                           [arrDataSearched count]* 30)];
            [mTableViewSuggest reloadData];
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.localSearch != nil)
    {
        self.localSearch = nil;
    }
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)selectLocationFrom:(UITapGestureRecognizer *)recognizer {
//    [viewLocationFrom setBackgroundColor:[UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f]];
//    [viewLocationTo setBackgroundColor:[UIColor whiteColor]];
//    [mLocationFrom setTextColor:[UIColor whiteColor]];
//    [mLocationTo setTextColor:[UIColor blackColor]];
    locationTabPosition = 0;
}

- (void)selectLocationTo:(UITapGestureRecognizer *)recognizer {
//    [viewLocationTo setBackgroundColor:[UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f]];
//    [viewLocationFrom setBackgroundColor:[UIColor whiteColor]];
//    [mLocationTo setTextColor:[UIColor whiteColor]];
//    [mLocationFrom setTextColor:[UIColor blackColor]];
    locationTabPosition = 1;
}

- (void)viewDidDisappear:(BOOL)animated {
    //add gesture to map
    [viewLocationFrom removeGestureRecognizer:gestureFrom];
    [viewLocationTo removeGestureRecognizer:gestureTo];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self getCoor];
}

- (void) getReverseGeocode:(CLLocationCoordinate2D) coordinate
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocationCoordinate2D myCoOrdinate;
    
    myCoOrdinate.latitude = coordinate.latitude;
    myCoOrdinate.longitude = coordinate.longitude;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:myCoOrdinate.latitude longitude:myCoOrdinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error)
         {
             NSLog(@"failed with error: %@", error);
             return;
         }
         if(placemarks.count > 0)
         {
             NSString *address = @"";
             NSString *city = @"";
             CLPlacemark *placemark = placemarks[0];
             
             if([placemark.addressDictionary objectForKey:@"FormattedAddressLines"] != NULL) {
                 address = [[placemark.addressDictionary objectForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             } else {
                 address = @"Address Not founded";
             }
             if ([placemark.addressDictionary objectForKey:@"SubAdministrativeArea"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"SubAdministrativeArea"];
             else if([placemark.addressDictionary objectForKey:@"City"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"City"];
             else if([placemark.addressDictionary objectForKey:@"Country"] != NULL)
                 city = [placemark.addressDictionary objectForKey:@"Country"];
             else
                 city = @"City Not founded";
             
             if (locationTabPosition == 0) {
                 mLocationFrom.text = address;
                 if ([address length]>30) {
                     mLocationFrom.text=[address substringToIndex:[address length] - 27];
                 }
                 placeFrom = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
             } else {
                 mLocationTo.text = address;
                 if ([address length]>30) {
                     mLocationTo.text=[address substringToIndex:[address length] - 27];
                 }
                 placeTo = [[MKPlacemark alloc] initWithCoordinate:myCoOrdinate addressDictionary:placemark.addressDictionary];
             }
             
             
         }
     }];
    
}


- (void)getCoor {
    CGPoint point = mImageFocus.frame.origin;
    point.x = point.x + mImageFocus.frame.size.width / 2;
    point.y = point.y + mImageFocus.frame.size.height;
    if (locationTabPosition == 0) {
        coordinateFrom = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateFrom];
    } else {
        coordinateTo = [mapview convertPoint:point toCoordinateFromView:mapview];
        [self getReverseGeocode:coordinateTo];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu:(id)sender {
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    [self.frostedViewController presentMenuViewController];
}
- (IBAction)findWay:(id)sender {
    
    [self.mapview removeOverlays:self.mapview.overlays];
    
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    
    [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placeFrom]];
    [directionsRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placeTo]];
    
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            routeDetails = response.routes.lastObject;
            [self.mapview addOverlay:routeDetails.polyline];
            for (int i = 0; i < routeDetails.steps.count; i++) {
                MKRouteStep *step = [routeDetails.steps objectAtIndex:i];
                NSString *newStep = step.instructions;
                NSLog(@"Step:%@",newStep);
            }
        }
    }];
    
}

- (IBAction)BookNow:(id)sender {
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;

    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor colorWithRed:255/255.0f green:59/255.0f blue:0/255.0f alpha:1.0f];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
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
                             f.origin.y = 368; // new y
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
                             f.origin.y = 368; // new y
                             self.ViewDetail.frame = f;
                         }
                         completion:^(BOOL finished){
                             NSLog(@"Done!");
                         }];
    };

    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire],[JPSThumbnailAnnotation annotationWithThumbnail:empire2]];
}

@end
