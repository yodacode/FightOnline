//
//  FightDetailViewController.m
//  fight
//
//  Created by Benjamin on 18/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "FightDetailViewController.h"

@interface FightDetailViewController ()

@end



@implementation FightDetailViewController
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
        [self.nameTextField setText:[self.fight valueForKey:@"name"]];
        self.nameTextField.delegate = self;
        [self.addressTextField setText:[self.fight valueForKey:@"address"]];
        self.addressTextField.delegate = self;
        NSString * fightersNumber = [NSString stringWithFormat:@"%@", [self.fight valueForKey:@"fightersnumber"]];
        [self.fighternumberTextField setText:fightersNumber];
        self.fighternumberTextField.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)save:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    // Get the current date
    
    if (self.fight) {

        // Update existing fight
        [self.fight setValue:self.nameTextField.text forKey:@"name"];
        [self.fight setValue:self.addressTextField.text forKey:@"address"];
        [self.fight setValue:[NSNumber numberWithInteger:[self.fighternumberTextField.text integerValue]] forKey:@"fightersnumber"];
        NSDate * dateForFight = self.dateFight.date;
        [self.fight setValue:dateForFight forKey:@"datefight"];
        
    } else {
        // Create a new fight
        NSManagedObject *newFight = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
        [newFight setValue:self.nameTextField.text forKey:@"name"];
        [newFight setValue:self.addressTextField.text forKey:@"address"];
        [newFight setValue:[NSNumber numberWithInteger:[self.fighternumberTextField.text integerValue]] forKey:@"fightersnumber"];
        
        NSDate * dateForFight = self.dateFight.date;
        [newFight setValue:dateForFight forKey:@"datefight"];
        [newFight setValue:@"Nolimit" forKey:@"adminname"];
        
        
    }

    
    NSError *error = nil;
    //Sauvegarde du nouvel objet persistant
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


@end
