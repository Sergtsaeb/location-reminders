//
//  LocationController.h
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@protocol LocationControllerDelegate <NSObject>
@required
- (void)locationControllerUpdatedLocation:(CLLocation *)location;

@end

@interface LocationController : NSObject

+(LocationController *)sharedLocationController;

@property(strong, nonatomic) CLLocationManager *locationManager;
@property(strong, nonatomic) CLLocation *location;
@property(weak, nonatomic) id delegate;

@end
