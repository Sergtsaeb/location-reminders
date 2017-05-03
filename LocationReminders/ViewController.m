//
//  ViewController.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/1/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "ViewController.h"
#import "AddReminderViewController.h"
#import "LocationController.h"

@import Parse;
@import MapKit;

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self requestPermissions];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    
//    testObject[@"testName"] = @"Serg Tsogtbaatar";
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        
//        if (succeeded) {
//            NSLog(@"Success saving test object!");
//        } else {
//            NSLog(@"There was a problem saving. Save error: %@", error.localizedDescription);
//        }
//    }];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//        } else {
//            NSLog(@"Query Results %@", objects);
//        }
//    }];
    
}

-(void)requestPermissions {
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters
    
//    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
}

- (IBAction)location1Pressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.608013, -122.335167);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    point.coordinate = coordinate;
//    point.title
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)location2Pressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(38.575764, -121.478851);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 600.0, 600.0);
    
    [self.mapView setRegion:region animated:YES];
    
}

- (IBAction)location3Pressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(13.04016, 80.243044);
    
    MKCoordinateRegion region =MKCoordinateRegionMakeWithDistance(coordinate, 600.0, 600.0);
    
    [self.mapView setRegion:region animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddReminderViewController"] && [sender isKindOfClass:[MKAnnotationView class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *)sender;
        
        AddReminderViewController *newReminderViewController = (AddReminderViewController *)segue.destinationViewController;
        
        newReminderViewController.coordinate = annotationView.annotation.coordinate;
        newReminderViewController.annotationTitle = annotationView.annotation.title;
        
        
    }
    
}

- (IBAction)userLongPressed:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        
        newPoint.coordinate = coordinate;
        newPoint.title = @"New location ayy";
        
        [self.mapView addAnnotation:newPoint];
        
    }
    
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    annotationView.annotation = annotation;
    
    if(!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    UIButton *rightCalloutAccessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.rightCalloutAccessoryView = rightCalloutAccessory;
    
    return annotationView;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    NSLog(@"Accessory Tapped!");
    [self performSegueWithIdentifier:@"AddReminderViewController" sender:view];
    
}

- (void)locationControllerUpdatedLocation:(CLLocation *)location {
//
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    self.locationManager.delegate = self;
//    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Coordinate:%f, %f - Altitude:%f", location.coordinate.latitude,location.coordinate.longitude, location.altitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0);
    
    [self.mapView setRegion:region animated:YES];
   
}

@end
