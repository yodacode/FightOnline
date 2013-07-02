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
        
        NSDate *fightdate = [self.fight valueForKey:@"datefight"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSString *stringFromDate = [formatter stringFromDate:fightdate];
        self.labelDateFight.text = stringFromDate;
        
    }
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    //  UIButton *buttonThatWasPressed = (UIButton *)sender;
    //    buttonThatWasPressed.enabled = NO;
    
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

@end
