//
//  TDToDoViewController.h
//  ToDo
//
//  Created by Gregory Casamento on 12/2/13.
//  Copyright (c) 2013 Gregory Casamento. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDToDoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *sortOrder;
    
    NSMutableDictionary *taskDictionary;
    NSArray *taskResults;
    NSMutableArray *keyArray;
}

- (IBAction)logoutPressed:(id)sender;
- (IBAction)addTask:(id)sender;
- (IBAction)changeSort:(id)sender;

@end
