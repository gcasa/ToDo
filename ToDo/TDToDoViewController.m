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
#import "TDCell.h"

@interface TDToDoViewController ()

@end

@implementation TDToDoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:@"TDTaskAddedNotification"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNotification:)
                                                     name:@"TDTaskRemovedNotification"
                                                   object:nil];
    }
    return self;
}

- (void) buildDictionary
{
    // Re-initialize everything...
    [taskDictionary removeAllObjects];
    [keyArray removeAllObjects];
    taskDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
    keyArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    if([sortOrder.text isEqualToString:@"Priority"])
    {
        NSNumber *currentPriority;
        for(Task *task in taskResults)
        {
            NSMutableArray *array = nil;
            if([currentPriority isEqualToNumber:task.priority])
            {
                array = [taskDictionary objectForKey:task.priority];

            }
            else
            {
                array = [[NSMutableArray alloc] initWithCapacity:10];
                currentPriority = task.priority;
                [taskDictionary setObject:array forKey:task.priority];
                [keyArray addObject:task.priority];
            }
            [array addObject:task];
        }
    }
    else
    {
        NSDate *currentDate;
        for(Task *task in taskResults)
        {
            NSMutableArray *array = nil;
            if([currentDate isEqualToDate:task.date])
            {
                array = [taskDictionary objectForKey:task.date];
            }
            else
            {
                array = [[NSMutableArray alloc] initWithCapacity:10];
                currentDate = task.date;
                [taskDictionary setObject:array forKey:task.date];
                [keyArray addObject:task.date];
            }
            [array addObject:task];
        }
    }
}

- (void) rebuildData
{
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    TDSession *session = [delegate session];
    User *user = [session user];
    
    NSManagedObjectContext *moc = [delegate managedObjectContext];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Task"
                                                   inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId = %@)",
                              user.userId];

    NSMutableArray *descriptors = [[NSMutableArray alloc] initWithCapacity:2];
    if([sortOrder.text isEqualToString:@"Priority"])
    {
        NSSortDescriptor *descriptor = nil;
        descriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];
        [descriptors addObject:descriptor];
        descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [descriptors addObject:descriptor];
    }
    else
    {
        NSSortDescriptor *descriptor = nil;
        descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        [descriptors addObject:descriptor];
        descriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];
        [descriptors addObject:descriptor];
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    [request setPredicate:predicate];
    [request setSortDescriptors:descriptors];
    
    NSError *error = nil;
    taskResults = [moc executeFetchRequest:request error:&error];
    
    // build dictionary from results
    [self buildDictionary];
}

- (void) refreshContents
{
    [self rebuildData];
    [tableView reloadData];
}

- (void)handleNotification:(NSNotification *)notification
{
    [self refreshContents];
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *order = [defaults objectForKey:@"sortOrder"];
    if(order != nil)
    {
        sortOrder.text = order;
        [self performSelector:@selector(changeSort:)
                   withObject:nil
                   afterDelay:(NSTimeInterval)1];
    }
    
    [self refreshContents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"userId"];
    [defaults removeObjectForKey:@"passwordHash"];
    [defaults synchronize];
    
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addTask:(id)sender
{
    TDAddTaskViewController *addTaskController = [[TDAddTaskViewController alloc]
                                                  initWithNibName:@"TDAddTaskViewController"
                                                           bundle:nil];
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController presentViewController:addTaskController animated:YES completion:^{}];
}

- (void)changeSort:(id)sender
{
    if([sortOrder.text isEqualToString:@"Date"])
    {
        sortOrder.text = @"Priority";
    }
    else
    {
        sortOrder.text = @"Date";
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sortOrder.text
                 forKey:@"sortOrder"];
    [defaults synchronize];
    [self refreshContents];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id obj = [keyArray objectAtIndex:section];
    NSArray *array = [taskDictionary objectForKey:obj];
    return [array count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierForCell = @"TDCell";
    
    TDCell *cell = (TDCell *)[tv dequeueReusableCellWithIdentifier:identifierForCell];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ToDoCell" owner:nil options:nil];
        for (id eachObject in nib) {
            if ([eachObject isKindOfClass:[UITableViewCell class]]) {
                cell = eachObject;
                break;
            }
        }
    }
    
    NSUInteger kindex = [indexPath indexAtPosition:0];
    NSUInteger dindex = [indexPath indexAtPosition:1];
    id key = [keyArray objectAtIndex:kindex];
    NSArray *detailArray = [taskDictionary objectForKey:key];
    Task *task = [detailArray objectAtIndex:dindex];
    
    cell.task = task;
    [cell resetState];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id key = [keyArray objectAtIndex:section];
    NSString *returnValue = nil;
    
    returnValue = [NSString stringWithFormat:@"%@",key];
    if([key isKindOfClass:[NSDate class]])
    {
        NSArray *components = [returnValue componentsSeparatedByString:@" "];
        if([components count] > 0)
        {
            returnValue = [components objectAtIndex:0];
        }
    }
    
    return returnValue;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDAddTaskViewController *addTaskController = [[TDAddTaskViewController alloc] initWithNibName:@"TDAddTaskViewController" bundle:nil];
    
    NSUInteger kindex = [indexPath indexAtPosition:0];
    NSUInteger dindex = [indexPath indexAtPosition:1];
    id key = [keyArray objectAtIndex:kindex];
    NSArray *detailArray = [taskDictionary objectForKey:key];
    Task *task = [detailArray objectAtIndex:dindex];
    
    addTaskController.currentTask = task;
    
    TDAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navigationController presentViewController:addTaskController
                                                animated:YES
                                              completion:^{}];
}
@end
