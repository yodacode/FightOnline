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

@interface FightDescrViewController ()

@end

@implementation FightDescrViewController
@synthesize fight;

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
        
        if(dispoValue == value){
            self.labelDispo.textLabel.text = @"Complet";
            self.labelDispo.textColor=[UIColor redColor];
            self.cellParticipate.hidden = YES;
        }
        
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


- (IBAction)participate:(id)sender {
    if(self.fight){
        
        NSManagedObjectContext *context = [self managedObjectContext];
        NSNumber *dispo = [self.fight valueForKey:@"fightersnumber"];
        NSNumber *number = [self.fight valueForKey:@"fightersattending"];
        int dispoValue = [dispo intValue];
        int value = [number intValue];
        
        if(dispoValue-1 == value){
            self.cellParticipate.hidden = YES;
            self.labelDispo.textLabel.text = @"Complet";
            self.labelDispo.textColor=[UIColor redColor];
        }
        
        number = [NSNumber numberWithInt:value + 1];        
        [self.fight setValue:number forKey:@"fightersattending"];
        NSError *error = nil;
        [context save:&error];

        [self viewDidAppear:YES];
    }
}
@end
