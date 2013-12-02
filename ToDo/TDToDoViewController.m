//
//  TDToDoViewController.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDToDoViewController.h"
#import "TDAddTaskViewController.h"
#import "TDAppDelegate.h"

@interface TDToDoViewController ()

@end

@implementation TDToDoViewController

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
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(addTask:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userId"];
    [defaults removeObjectForKey:@"passwordHash"];
}

- (IBAction)addTask:(id)sender
{
    TDAddTaskViewController *addTaskController = [[TDAddTaskViewController alloc]
                                                  initWithNibName:@"TDAddTaskViewController"
                                                           bundle:nil];
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController presentViewController:addTaskController animated:YES completion:^{}];
}

- (void)changeSort:(id)sender
{
    if([sortOrder.text isEqualToString:@"Date"])
    {
        sortOrder.text = @"Priority";
    }
    else
    {
        sortOrder.text = @"Date";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
