//
//  FightDescrViewController.m
//  fight
//
//  Created by Benjamin on 02/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "FightDescrViewController.h"
#import "FightDetailViewController.h"
#import "FightLocationViewController.h"
#import "User.h"
#import "Fight.h"

@interface FightDescrViewController ()

@end

@implementation FightDescrViewController
@synthesize fight;
@synthesize socialText;

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
    if (self.fight) {
        [self initRender];
    }
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UpdateFight"]) {
        NSManagedObject *selectedFight = self.fight;
        FightDetailViewController *destViewController = segue.destinationViewController;
        destViewController.fight  = selectedFight;
    }
    if([[segue identifier] isEqualToString:@"GetMap"]) {
        NSManagedObject *selectedFight = self.fight;
        FightLocationViewController *destViewController = segue.destinationViewController;
        destViewController.fight  = selectedFight;
    }
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}



- (BOOL) isInfight {
    id currentFight = self.fight;
    Fight * thisFight = currentFight;
    NSSet *users = thisFight.users;
    
    if(users.count > 0) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)initRender {
    
    self.labelName.text = [self.fight valueForKey:@"name"];
    self.labelAddress.text = [self.fight valueForKey:@"address"];
    
    NSString *fightersnumber = [NSString stringWithFormat:@"%@", [self.fight valueForKey:@"fightersnumber"]];
    self.labelFightersNumber.text = fightersnumber;
    
    NSString *fightersattending = [NSString stringWithFormat:@"%@ %@", [self.fight valueForKey:@"fightersattending"],@"/"];
    self.labelFightersAttending.text = fightersattending;
    
    NSDate *fightdate = [self.fight valueForKey:@"datefight"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:fightdate];
    self.labelDateFight.text = stringFromDate;
    
    NSNumber *dispo = [self.fight valueForKey:@"fightersnumber"];
    NSNumber *number = [self.fight valueForKey:@"fightersattending"];
    int dispoValue = [dispo intValue];
    int value = [number intValue];
    
    self.socialText = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@ %@", self.labelName.text,@"\n Lieu:",self.labelAddress.text,@"\n Date :",self.labelDateFight.text,@"\n Participants :",self.labelFightersAttending.text,self.labelFightersNumber.text,@"\n"];
    
    if(dispoValue == value){
        self.labelDispo.textLabel.text = @"Complet";
        self.labelDispo.textColor=[UIColor redColor];
        self.cellParticipate.hidden = YES;
    }
    
    if([self isInfight]){
        self.labelDispo.textLabel.text = @"Vous y participez";
        self.labelDispo.textColor=[UIColor blueColor];
        self.cellParticipate.hidden = YES;
    }
    
    
}

- (IBAction)participate:(id)sender {
    if(self.fight){
        
        NSManagedObjectContext *context = [self managedObjectContext];
        NSNumber *dispo = [self.fight valueForKey:@"fightersnumber"];
        NSNumber *number = [self.fight valueForKey:@"fightersattending"];
        int dispoValue = [dispo intValue];
        int value = [number intValue];
        
        if(dispoValue - 1 == value){
            self.cellParticipate.hidden = YES;
            self.labelDispo.textLabel.text = @"Complet";
            self.labelDispo.textColor=[UIColor redColor];
        }
        
        number = [NSNumber numberWithInt:value + 1];        
        [self.fight setValue:number forKey:@"fightersattending"];
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", @"Fred", @"Nolimit"];
        [fetchRequest setEntity:entity];
        [fetchRequest setPredicate:predicate];
        NSError *error0 = nil;
        id currentUser = [[context executeFetchRequest:fetchRequest error:&error0] lastObject];
        User * user2 = currentUser;
        
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Fight" inManagedObjectContext:context];
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"name like %@", [self.fight valueForKey:@"name"]];
        [fetchRequest setEntity:entity2];
        [fetchRequest setPredicate:predicate2];
        NSError *error2 = nil;
        id currentFight = [[context executeFetchRequest:fetchRequest error:&error2] lastObject];
        Fight * fight2 = currentFight;
        
        // Set relationships
       [user2 addFightsObject:fight2];
        //[fight addUsersObject:user];
        
        
        
        NSError *error = nil;
        [context save:&error];

        [self viewDidAppear:YES];
    }
}
- (IBAction)postFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:self.socialText];
        [controller addURL:[NSURL URLWithString:@"https://github.com/yodacode/FightOnline"]];
        [controller addImage:[UIImage imageNamed:@"racaille.jpg"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)postTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:self.socialText];
        [tweetSheet addImage:[UIImage imageNamed:@"racaille.jpg"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
@end
