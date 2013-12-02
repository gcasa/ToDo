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

- (IBAction)addTask:(id)sender
{
    TDAddTaskViewController *addTaskController = [[TDAddTaskViewController alloc]
                                                  initWithNibName:@"TDAddTaskViewController"
                                                           bundle:nil];
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController presentViewController:addTaskController animated:YES completion:^{}];
}

@end
