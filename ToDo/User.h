//
//  User.h
//  ToDo
//
//  Created by Gregory Casamento on 7/2/14.
//  Copyright (c) 2014 Gregory Casamento. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *userId;

@end
