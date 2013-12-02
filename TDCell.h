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
}

@property (nonatomic, strong) IBOutlet UILabel *detailText;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) Task *task;

- (IBAction)closeButton:(id)sender;
- (IBAction)doneButton:(id)sender;
- (void)resetState;

@end
