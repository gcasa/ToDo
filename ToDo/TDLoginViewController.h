//
//  TDLoginViewController.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDLoginViewController : UIViewController
{
    IBOutlet UITextField *userId;
    IBOutlet UITextField *password;
}

- (IBAction)login:(id)sender;
- (IBAction)registerUser:(id)sender;

@end
