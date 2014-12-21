//
//  TDRegisterViewController.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDRegisterViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate>
{
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *middleName;
    IBOutlet UITextField *lastName;
    IBOutlet UITextField *userId;
    IBOutlet UITextField *password;
    IBOutlet UITextField *confirmPassword;
    IBOutlet UITextField *phoneNumber;
    IBOutlet UITextField *email;
    
    IBOutlet UIButton *registerUser;
}

- (IBAction)registerUser:(id)sender;

@end
