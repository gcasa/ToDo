//
//  TDAddTaskViewController.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDAddTaskViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UITextView   *descriptionText;
    IBOutlet UITextField  *taskName;
    IBOutlet UITextField  *dateField;
}
@end
