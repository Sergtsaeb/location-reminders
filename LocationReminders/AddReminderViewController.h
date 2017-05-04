//
//  AddReminderViewController.h
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

typedef void(^NewReminderCreatedCompletion)(MKCircle *);

@interface AddReminderViewController : UIViewController <UITextFieldDelegate>

@property(strong, nonatomic)UITextField *nameTextField;
@property(strong, nonatomic)UITextField *radiusTextField;

@property(strong, nonatomic) NSString *annotationTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@property(strong, nonatomic) NewReminderCreatedCompletion completion;

@end
