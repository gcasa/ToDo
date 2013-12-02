//
//  NSDate+Utilities.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

-(NSDate *)dateWithOutTime
{
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:self];
    [comps setHour:00];
    [comps setMinute:00];
    [comps setSecond:00];
    [comps setTimeZone:[NSTimeZone defaultTimeZone]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

@end
