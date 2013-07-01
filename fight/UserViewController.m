//
//  UserViewController.m
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "UserViewController.h"

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
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", @"Benjamin", @"DEVAUBLANC"];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];

    //si il n'y a pas de resultats
    if(matchingData.count <= 0)
    {
        NSManagedObject *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        [newUser setValue:@"DEVAUBLANC" forKey:@"name"];
        [newUser setValue:@"Benjamin" forKey:@"firstname"];
        self.user = newUser;
        [self.managedObjectContext save:nil];
    } else
    {
        NSString *firstName;
        NSString *lastName;
        for(NSManagedObject *obj in matchingData){
            firstName = [obj valueForKey:@"firstname"];
            lastName = [obj valueForKey:@"name"];
        }
    

        self.nameLabel.text = [NSString stringWithFormat:@"%@, %@",firstName, lastName];
    
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





@end
