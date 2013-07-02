//
//  UserViewController.m
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "UserViewController.h"
#import "UserUpdateProfilViewController.h"
#import "UserOrganisedViewController.h"
#import "User.h"
#import "Fight.h"

@interface UserViewController ()

@end

@implementation UserViewController
@synthesize user;
@synthesize fights;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", @"Fred", @"Nolimit"];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    id currentUser = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    fetchRequest = nil;
    self.user = currentUser;
    
    User * cuser = currentUser;
    NSSet *tapes = cuser.fights;
    NSNumber * counterFight = [NSNumber numberWithInt:tapes.count];
    
    //init render
    self.organisedLabel.text = [NSString stringWithFormat:@"%@,%@", counterFight, @" tapes"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@,%@", [self.user valueForKey:@"name"], [self.user valueForKey:@"firstname"]];
    
    for (Fight *fight in tapes) {
        NSLog(@"\t\t%@ ", fight.name);
    }
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UpdateProfil"]) {
        NSManagedObject *selectedUser = self.user;
        UserUpdateProfilViewController *destViewController = segue.destinationViewController;
        destViewController.user  = selectedUser;
    }
    if ([[segue identifier] isEqualToString:@"GetFightOrganised"]) {
        NSManagedObject *selectedUser = self.user;
         UserOrganisedViewController *destViewController = segue.destinationViewController;
        destViewController.user  = selectedUser;
    }

}







@end
