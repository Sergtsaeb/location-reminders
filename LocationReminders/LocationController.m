//
//  LocationController.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "LocationController.h"
@import UserNotifications;

@implementation LocationController
@synthesize locationManager;
@synthesize location;

+(LocationController *)sharedLocationController {
    
    static LocationController *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

-(id)init {
    if (self == [super init]) {
        location = [[CLLocation alloc]init];
        locationManager = [[CLLocationManager alloc]init];
    }
    return self;
}

-(void)startMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startMonitoringForRegion:region];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    self.location = location;
    
    [self.delegate locationControllerUpdatedLocation:location];
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region {
    NSLog(@"User did Enter region: %@", region.identifier);
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Reminder";
    content.body = [NSString stringWithFormat:@"%@", region.identifier];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location Entered" content:content trigger:trigger];
    
    UNUserNotificationCenter *current = [UNUserNotificationCenter currentNotificationCenter];
    
    [current removeAllPendingNotificationRequests];
    [current addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Posting User Notification: %@", error.localizedDescription);
        }
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(nonnull CLRegion *)region {
    
    NSLog(@"User did Exit region: %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    
    NSLog(@"There was an error: %@", error.localizedDescription);
}

-(void)locationManager:(CLLocationManager *)manager didVisit:(nonnull CLVisit *)visit {
    
    NSLog(@"This is here for no reason, but heres a visit: %@", visit);
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(nonnull CLRegion *)region {
    
    NSLog(@"We have successfully started monitoring for changes for region: %@", region.identifier);
}

@end
