//
//  TDCell.m
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import "TDCell.h"
#import "TDAppDelegate.h"

static UIImage *uncheckedImage = nil;
static UIImage *checkedImage = nil;

@implementation TDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        done = NO;
        
        if(uncheckedImage == nil)
        {
            uncheckedImage = [UIImage imageNamed:@"CheckmarkOff"];
            checkedImage = [UIImage imageNamed:@"CheckmarkOn"];
        }
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
}

- (IBAction)doneButton:(id)sender
{
    NSLog(@"Done");
    if(done)
    {
        [doneButton setImage:uncheckedImage
                    forState:UIControlStateNormal];
        done = NO;
    }
    else
    {
        [doneButton setImage:checkedImage
                    forState:UIControlStateNormal];
        done = YES;
    }
    
    task.completed = [NSNumber numberWithBool:done];
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
}
@end
