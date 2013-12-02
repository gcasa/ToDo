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
    // NSString *passwordHash = [passwordString stringByHashingStringWithSHA1];
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"User"
                                                   inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId = %@ AND password = %@)",
                              userIdString, passwordHash];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if([array count] > 0)
    {
        User *user = [array objectAtIndex:0];
        delegate.session = [[TDSession alloc] init];
        delegate.session.user = user;
        
        // Save logged in user...
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userIdString forKey:@"userId"];
        [defaults setObject:passwordHash forKey:@"passwordHash"];
        
        // Open controller...
        TDToDoViewController *todoViewController = [[TDToDoViewController alloc]
                                                    initWithNibName:@"TDToDoViewController"
                                                    bundle:nil];
        
        TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [[delegate navigationController] pushViewController:todoViewController
                                                   animated:YES];
    }
    else
    {
        UIAlertView *loginFailedView = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Login failure, please try again or register" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //errorText.text = @"Login failure, please register.";
        loginFailedView.delegate = self;
        [loginFailedView show];
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
