//
//  TDCell.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDCell.h"
#import "TDAppDelegate.h"

@implementation TDCell

@synthesize detailText = _detailText;
@synthesize doneButton = _doneButton;
@synthesize task = _task;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)closeButton:(id)sender
{
    NSLog(@"Close");
    [self.task deleteInBackground];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TDTaskRemovedNotification"
                                                        object:nil];
}

- (IBAction)doneButton:(id)sender
{
    if([[self.task objectForKey:@"completed"] boolValue])
    {
        [self.task setObject:[NSNumber numberWithBool:NO]
                      forKey:@"completed"];
    }
    else
    {
        [self.task setObject:[NSNumber numberWithBool:YES]
                      forKey:@"completed"];
    }
    [self resetState];

    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
}

- (void)resetState
{
    if([[self.task objectForKey:@"completed"] boolValue])
    {
        UIImage *image = [UIImage imageNamed:@"CheckmarkOff.jpg"];
        [self.doneButton setImage:image
                         forState:UIControlStateNormal];
    }
    else
    {
        UIImage *image = [UIImage imageNamed:@"CheckmarkOn.jpg"];
        [self.doneButton setImage:image
                         forState:UIControlStateNormal];
    }
    
    self.detailText.text = [self.task objectForKey:@"detail"];
}
@end
