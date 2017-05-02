//
//  LocationController.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "LocationController.h"

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

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    
    [self.delegate locationControllerUpdatedLocation:location];
}


@end
