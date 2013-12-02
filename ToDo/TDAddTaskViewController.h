//
//  TDAddTaskViewController.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface TDAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextView *descriptionText;
    IBOutlet UITextField *taskName;
    IBOutlet UIStepper *stepper;
    IBOutlet UITextField *priority;
}

@property (nonatomic,strong) Task *currentTask;

- (IBAction)dateSelected:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)stepperPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end
