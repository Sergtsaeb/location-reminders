//
//  Reminder.h
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/3/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject <PFSubclassing>

+(NSString *)parseClassName;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) PFGeoPoint *location;
@property(strong, nonatomic) NSNumber *radius;

@end
