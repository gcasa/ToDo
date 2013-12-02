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

- (IBAction)login:(id)sender
{
    NSString *passwordString = [password.text stringByHashingStringWithSHA1];
    
}

- (IBAction)registerUser:(id)sender
{
    TDRegisterViewController *registerController = [[TDRegisterViewController alloc]
                                                    initWithNibName:@"TDRegisterViewController" bundle:nil];
    
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [[delegate navigationController] pushViewController:registerController animated:YES];
}

@end
