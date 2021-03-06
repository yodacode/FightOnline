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
#import "UserCreatedViewController.h"
#import "User.h"
#import "Fight.h"
#import "CurrentUser.h"

@interface UserViewController ()

@end

@implementation UserViewController
@synthesize user;
@synthesize fights;
@synthesize fightsAttending;
@synthesize fightsCreated;

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
    
    

    
    [self initFightsAttendingForSegue];
    [self initFightsCreatedForSegue];
    
    //init render
    NSNumber * counterFightsAttending = [NSNumber numberWithInt:self.fightsAttending.count];
    NSNumber * counterFightsCreated = [NSNumber numberWithInt:self.fightsCreated.count];
    
    self.organisedLabel.text = [NSString stringWithFormat:@"%@,%@", counterFightsAttending, @" tapes"];
    self.createdLabel.text = [NSString stringWithFormat:@"%@,%@", counterFightsCreated, @" tapes"];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@,%@", [self.user valueForKey:@"name"], [self.user valueForKey:@"firstname"]];
    self.ageLabel.text = [NSString stringWithFormat:@"%@", [self.user valueForKey:@"age"]];
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@", [self.user valueForKey:@"profildescr"]];

    //obj.name= [matchingData valueForKey:@"name"];
    
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) initFightsCreatedForSegue {

    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Fight" inManagedObjectContext:context]];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"adminname like %@", [self.user valueForKey:@"name"]];
    [request setPredicate:predicate2];
    
    NSError *error = nil;
    NSMutableArray *fightsMutArray =[[NSMutableArray alloc] init];

    NSArray * tapes = [context executeFetchRequest:request error:&error];
    for (NSArray *fight in tapes) {
        [fightsMutArray addObject:fight];
    }
    
    self.fightsCreated = fightsMutArray;

}

- (void) initFightsAttendingForSegue {
    
    CurrentUser *CU=[CurrentUser getInstance];
    
    NSLog( @"%@" , [[CU valueForKey:@"name"] firstObject]);
    
    NSString * firstname =  [NSString stringWithFormat:@"%@" , [[CU valueForKey:@"firstname"] firstObject]];
    NSString * name =  [NSString stringWithFormat:@"%@" , [[CU valueForKey:@"name"] firstObject]];
    NSString * email =  [NSString stringWithFormat:@"%@" , [[CU valueForKey:@"email"] firstObject]];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@ and email like %@", firstname, name, email];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    id currentUser = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    fetchRequest = nil;
    self.user = currentUser;
    
    User * cuser = currentUser;
    NSSet *tapes = cuser.fights;
    
    
    NSMutableArray *fightsMutArray =[[NSMutableArray alloc] init];
    for (Fight *fight in tapes) {
        [fightsMutArray addObject:fight];
    }
    self.fightsAttending = fightsMutArray;
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
        NSMutableArray *selectedFights = self.fightsAttending;
         UserOrganisedViewController *destViewController = segue.destinationViewController;
        destViewController.fights  = selectedFights;
    }
    if ([[segue identifier] isEqualToString:@"GetFightCreated"]) {
        NSMutableArray *selectedFights = self.fightsCreated;
        UserCreatedViewController *destViewController = segue.destinationViewController;
        destViewController.fights  = selectedFights;
    }

}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}







@end
