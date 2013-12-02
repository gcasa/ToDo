//
//  Task.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * date;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * textDescription;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSManagedObject *user_task;

@end
