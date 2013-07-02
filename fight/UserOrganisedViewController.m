//
//  UserOrganisedViewController.m
//  fight
//
//  Created by Benjamin on 02/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "UserOrganisedViewController.h"
#import "UserViewController.h"
#import "FightDescrViewController.h"
#import "User.h"
#import "Fight.h"

@interface UserOrganisedViewController ()
@property (strong) NSMutableArray *fights;
@end

@implementation UserOrganisedViewController
@synthesize user;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    NSString * currentUserName = [self.user valueForKey:@"name"];
    NSString * currentUserFirstName = [self.user valueForKey:@"firstname"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", currentUserFirstName, currentUserName];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    id currentUser = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    fetchRequest = nil;
    self.user = currentUser;
    
    User * cuser = currentUser;
    NSSet *tapes = cuser.fights;
    NSMutableArray *mutArray=[[NSMutableArray alloc] init];
    
    for (Fight *fight in tapes) {
        [mutArray addObject:fight];
    }
    self.fights = mutArray;
    
    [self.tableView reloadData];
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.fights.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *fight = [self.fights objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [fight valueForKey:@"name"]]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ %@ %@ %@", @"(", [fight valueForKey:@"fightersnumber"], @")", [fight valueForKey:@"address"]]];
    
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GetDetailFight"]) {
        NSManagedObject *selectedFight = [self.fights objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        FightDescrViewController *destViewController = segue.destinationViewController;
        destViewController.fight  = selectedFight;
        destViewController.user = self.user;
    }
}


@end
