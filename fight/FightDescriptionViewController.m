//
//  FightDescriptionViewController.m
//  fight
//
//  Created by Benjamin on 19/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "FightDescriptionViewController.h"
#import "FightDetailViewController.h"

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
        //self.labelFightersNumber.text = [self.fight valueForKey:@"fightersnumber"];
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
}

@end
