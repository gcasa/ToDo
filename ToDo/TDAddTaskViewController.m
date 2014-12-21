//
//  TDAddTaskViewController.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDAddTaskViewController.h"
#import "Task.h"
#import "TDAppDelegate.h"
#import "NSDate+Utilities.h"
#import <MagicalRecord/NSManagedObject+MagicalRecord.h>

@interface TDAddTaskViewController ()

@end

@implementation TDAddTaskViewController

@synthesize currentTask = _currentTask;

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
    if(self.currentTask == nil)
    {
        priority.text = @"1";
    }
    else
    {
        priority.text = [[self.currentTask priority] stringValue];
        descriptionText.text = [self.currentTask textDescription];
        taskName.text = [self.currentTask detail];
        datePicker.date = [self.currentTask date];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissWithTask:(Task *)task
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TDTaskAddedNotification" object:task];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)donePressed:(id)sender
{
    if([taskName.text isEqualToString:@""] == NO &&
       [descriptionText.text isEqualToString:@""] == NO)
    {
        Task *task = nil;
        
        if(self.currentTask)
        {
            task = self.currentTask;
        }
        else
        {
            task = [[Task alloc] init];
        }
        task.detail = taskName.text;
        task.textDescription = descriptionText.text;
        task.date = [[datePicker date] dateWithOutTime];
        task.priority = [NSNumber numberWithInt:[priority.text intValue]];
        task.user = [User currentUser];
        task.completed = [NSNumber numberWithBool:NO];
        [task saveEventually:^(BOOL succeeded, NSError *error) {
            [self performSelectorInBackground:@selector(dismissWithTask:) withObject:task];
        }];
    }
    else
    {
        UIAlertView *registerFailedView = [[UIAlertView alloc] initWithTitle:@"Incomplete Details" message:@"Task detail must include task name and description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        registerFailedView.delegate = self;
        [registerFailedView show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // nothing to do...
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (IBAction)dateSelected:(id)sender
{
    [taskName resignFirstResponder];
    [descriptionText resignFirstResponder];
}

- (void)stepperPressed:(id)sender
{
    priority.text = [[NSNumber numberWithInt: (int)[stepper value]] stringValue];
    [taskName resignFirstResponder];
    [descriptionText resignFirstResponder];
}

- (void)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
}

@end