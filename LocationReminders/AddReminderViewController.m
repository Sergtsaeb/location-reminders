//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()

@property(strong, nonatomic)UITextField *name;
@property(strong, nonatomic)UITextField *reminder;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.delegate = self;
    self.reminder.delegate = self;
    
    NSLog(@"%@", self.annotationTitle);
    NSLog(@"Coordinates: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 15;
}

@end
