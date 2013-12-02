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

@interface TDAddTaskViewController ()

@end

@implementation TDAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        date = [[NSDate alloc] init];  // today, unless otherwise selected...
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    priority.text = @"1";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender
{
    if([taskName.text isEqualToString:@""] == NO &&
       [descriptionText.text isEqualToString:@""] == NO)
    {
        TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *moc = [delegate managedObjectContext];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:moc];
        Task *task = [[Task alloc] initWithEntity:description
                   insertIntoManagedObjectContext:moc];
        task.detail = taskName.text;
        task.textDescription = descriptionText.text;
        task.date = date;
        task.priority = [NSNumber numberWithInt:[priority.text intValue]];
        [delegate saveContext];
        [self dismissViewControllerAnimated:YES completion:^{}];
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
    date = [datePicker date];
}

- (void)stepperPressed:(id)sender
{
    priority.text = [[NSNumber numberWithInt: (int)[stepper value]] stringValue];
}

- (void)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                             }];
}

@end