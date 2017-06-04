//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@interface AddReminderViewController ()


@end

@implementation AddReminderViewController

//@synthesize nameTextField;
//@synthesize radiusTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    self.radiusTextField.delegate = self;
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 15;
}

- (IBAction)saveReminderPressed:(UIButton *)sender {
    
    Reminder *newReminder = [Reminder object];
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    newReminder.name = self.nameTextField.text;
    
    NSNumber *radius = [NSNumber numberWithFloat:self.radiusTextField.text.floatValue];
    if (radius == 0) {
        radius = [NSNumber numberWithFloat:100];
    }
    newReminder.radius = radius;
    
    NSLog(@"%@", newReminder.name);
    NSLog(@"%@", newReminder.radius);
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"%@", self.annotationTitle);
        NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
        
        NSLog(@"Save reminder successful: %i - Error: %@", succeeded, error.localizedDescription);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
        if (self.completion) {
            CGFloat overlayRadius = radius.floatValue;
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:overlayRadius];
            
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:overlayRadius identifier:newReminder.name];
                
                [LocationController.sharedLocationController startMonitoringForRegion:region];
            }
            
            self.completion(circle);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
