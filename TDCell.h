//
//  TDCell.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TDCell : UITableViewCell
{
    IBOutlet UIButton *closeButton;
    IBOutlet UIButton *doneButton;
    IBOutlet UILabel *detailText;
    
    BOOL done;
    Task *task;
}

- (IBAction)closeButton:(id)sender;
- (IBAction)doneButton:(id)sender;

@end
