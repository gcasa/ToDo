//
//  TDLoginViewController.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDLoginViewController.h"
#import "TDAppDelegate.h"
#import "TDRegisterViewController.h"
#import "TDToDoViewController.h"

#import "NSString+SHA1.h"
#import "User.h"

#import <Parse/Parse.h>
#import <PXAlertView/PXAlertView.h>

@interface TDLoginViewController ()

@end

@implementation TDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)authenticateWithUserName:(NSString *)userIdString
                 andPasswordHash:(NSString *)passwordHash
{
    User *user = [User logInWithUsername:userIdString password:passwordHash];
    if(user == nil)
    {
        [PXAlertView showAlertWithTitle:@"Login failed.  Please try again."];
    }
    else
    {
        TDToDoViewController *toDoViewController = [[TDToDoViewController alloc]
                                                    initWithNibName:@"TDToDoViewController"
                                                    bundle:nil];
        [self.navigationController pushViewController:toDoViewController animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userIdString = [defaults objectForKey:@"userId"];
    if(userIdString != nil)
    {
        NSString *passwordHash = [defaults objectForKey:@"passwordHash"];
        [self authenticateWithUserName:userIdString andPasswordHash:passwordHash];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender
{
    NSString *passwordHash = [password.text stringByHashingStringWithSHA1];
    [self authenticateWithUserName:userId.text
                   andPasswordHash:passwordHash];
}

- (IBAction)registerUser:(id)sender
{
    TDRegisterViewController *registerController = [[TDRegisterViewController alloc]
                                                    initWithNibName:@"TDRegisterViewController" bundle:nil];
    
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [[delegate navigationController] pushViewController:registerController animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == userId)
    {
        userId.text = @"";
        password.text = @"";
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Nothing to do...
}

@end
