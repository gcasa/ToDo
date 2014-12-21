//
//  Task.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "Task.h"
#import <Parse/PFObject+Subclass.h>

@implementation Task

@dynamic date;
@dynamic priority;
@dynamic textDescription;
@dynamic detail;
@dynamic completed;
@dynamic user;

+ (NSString *)parseClassName
{
    return NSStringFromClass(self);
}

@end
