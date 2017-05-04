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

@synthesize nameTextField;
@synthesize radiusTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *name = self.nameTextField.text;
    NSNumber *radius = self.radiusTextField.text;
    
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
    newReminder.name = self.annotationTitle;
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    newReminder.name = nameTextField.text.description;
    
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"%@", self.annotationTitle);
        NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
        
        NSLog(@"Save reminder successful: %i - Error: %@", succeeded, error.localizedDescription);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
        if (self.completion) {
            CGFloat radius = 100;
//            [NSNumber numberWithFloat: self.radiusTextField.text]; //for lab coming form UISlider/UITextfield
            
            MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
            
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:radius identifier:newReminder.name];
                
                [LocationController.sharedLocationController startMonitoringForRegion:region];
                
            }
            
            self.completion(circle);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
