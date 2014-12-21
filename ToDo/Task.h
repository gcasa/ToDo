//
//  Task.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>

@interface Task : PFObject <PFSubclassing>

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * textDescription;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) PFUser * user;

@end
