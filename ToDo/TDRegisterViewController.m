//
//  TDRegisterViewController.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDRegisterViewController.h"
#import "TDAppDelegate.h"
#import "NSString+SHA1.h"
#import <Parse/Parse.h>

@interface TDRegisterViewController ()

@end

@implementation TDRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerUser:(id)sender
{
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    /*
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"User"
                                                   inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId = %@)",
                              userId.text];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
     */
    PFQuery *query = [User query];
    [query whereKey:@"email" equalTo:email.text];
    // [
    NSArray *array = nil;
    if([array count] > 0)
    {
        UIAlertView *registerFailedView = [[UIAlertView alloc] initWithTitle:@"User Already Exists" message:@"User already exists, please choose another username." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        registerFailedView.delegate = self;
        [registerFailedView show];
    }
    else
    {
        if([userId.text isEqualToString:@""] == NO &&
           [password.text isEqualToString:@""] == NO &&
           [firstName.text isEqualToString:@""] == NO &&
           [lastName.text isEqualToString:@""] == NO &&
           [confirmPassword.text isEqualToString:@""] == NO &&
           [email.text isEqualToString:@""] == NO)
        {
            if([confirmPassword.text isEqualToString:password.text])
            {

                User *user = [User new];
                user.username = userId.text;
                user.password = [password.text stringByHashingStringWithSHA1];
                user.firstName = firstName.text;
                user.lastName = lastName.text;
                user.middleName = middleName.text;
                user.email = email.text;
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    [delegate.navigationController popViewControllerAnimated:YES];
                }];
            }
            else
            {
                UIAlertView *registerFailedView = [[UIAlertView alloc] initWithTitle:@"Password Mismatch" message:@"Passwords do not match, please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                registerFailedView.delegate = self;
                [registerFailedView show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // Nothing to do...
}

@end
