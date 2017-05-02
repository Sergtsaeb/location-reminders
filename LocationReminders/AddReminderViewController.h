//
//  AddReminderViewController.h
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/2/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface AddReminderViewController : UIViewController <UITextFieldDelegate>

@property(strong, nonatomic) NSString *annotationTitle;
@property(nonatomic) CLLocationCoordinate2D coordinate;

@end
