//
//  FightDescriptionViewController.m
//  fight
//
//  Created by Benjamin on 19/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "FightDescriptionViewController.h"
#import "FightDetailViewController.h"
#import "FightLocationViewController.h"

@interface FightDescriptionViewController ()
@end

@implementation FightDescriptionViewController
@synthesize fight;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.fight) {
        
        self.labelName.text = [self.fight valueForKey:@"name"];
        self.labelAddress.text = [self.fight valueForKey:@"address"];
        
        NSString *fightersnumber = [NSString stringWithFormat:@"%@", [self.fight valueForKey:@"fightersnumber"]];
        self.labelFightersNumber.text = fightersnumber;
        
//        NSString *longitude = [NSString stringWithFormat:@"%@", [self.fight valueForKey:@"longitude"]];
  //      self.labelLongitude.text = longitude;
        
        NSString *longitude = [NSString stringWithFormat:@"%f", [[self.fight valueForKey:@"longitude"] doubleValue]];
        self.labelLongitude.text = longitude;
        
        NSString *latitude = [NSString stringWithFormat:@"%f", [[self.fight valueForKey:@"latitude"] doubleValue]];
        self.labelLatitude.text = latitude;
        
        NSDate *fightdate = [self.fight valueForKey:@"datefight"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        NSString *stringFromDate = [formatter stringFromDate:fightdate];
        self.labelDateFight.text =stringFromDate;
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
