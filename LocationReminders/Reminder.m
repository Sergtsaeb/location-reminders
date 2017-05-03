//
//  Reminder.m
//  LocationReminders
//
//  Created by Sergelenbaatar Tsogtbaatar on 5/3/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic radius;
@dynamic location;

+(void)load{
    [super load];
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return @"Reminder";
}


@end
