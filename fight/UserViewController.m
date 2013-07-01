//
//  UserViewController.m
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "UserViewController.h"
#import "UserUpdateProfilViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController
@synthesize user;

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

    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request= [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", @"Benjamin", @"DEVAUBLANC"];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error;
    //Making a mutable copy here makes no sense.  There is never a reason to make this mutable
    //NSArray *entities = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    id currentUser = [[context executeFetchRequest:request error:&error] lastObject];
    request = nil;
    
    
    //si il n'y a pas de resultats
    if(!currentUser)
    {
        NSLog(@"Current USER EXIST PAS");
        NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [newUser setValue:@"DEVAUBLANC" forKey:@"name"];
        [newUser setValue:@"Benjamin" forKey:@"firstname"];
        self.user = newUser;
        [self.managedObjectContext save:nil];
        
    } else
    {
        self.user = currentUser;
        self.nameLabel.text = [NSString stringWithFormat:@"%@, %@",[self.user valueForKey:@"name"], [self.user valueForKey:@"firstname"]];
    }
    

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
        NSManagedObject *selectedFight = self.user;
        UserUpdateProfilViewController *destViewController = segue.destinationViewController;
        destViewController.user  = selectedFight;
    }
  
}







@end
