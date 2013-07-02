//
//  AppDelegate.m
//  fight
//
//  Created by Benjamin on 18/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "AppDelegate.h"
#import "Fight.h"
#import "User.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //[self create];
    [self read];
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;

    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];

    tabBarItem1.title = @"Fight";
    tabBarItem2.title = @"Profil";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"icon_gun_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_gun.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"icon_profile_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_profile.png"]];
    
    
    
    return YES;
}


- (void) create {
    // Grab the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Grab the User entity
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    // Set a User
    user.name = @"Nolimit";
    user.firstname = @"Fred";
    
    // Insert the Fight entity
    Fight *fight = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
    fight.name = @"Hideout kikk";
    fight.address = @"28 rue Troyon Sevres France";
    
    // Create a Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    NSDate *dateFight = [dateFormatter dateFromString:@"04/11/2014"];
    fight.datefight = dateFight;
    
    NSNumber * fightersNumber = [NSNumber numberWithInteger:14];
    fight.fightersnumber = fightersNumber;
    
    //Create fight 2
    Fight *fight2 = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
    fight2.name = @"Om fire";
    fight2.address = @"Trocadero Paris France";
    
    // Set relationships
    //[user addFightsObject:fight];
    //[fight addUsersObject:user];
    
    // Set relationships
    [user addFights:[NSSet setWithObjects:fight, fight2, nil]];
    //[user addFights:[NSSet setWithObject:fight,fight2,nil]];

    
    // Save everything
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
}





- (void) read {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Construct a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and name like %@", @"Fred", @"Nolimit"];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    //NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    id currentUser = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    
    User * user = currentUser;
    
    NSSet *fights = user.fights;
    for (Fight *fight in fights) {
        NSLog(@"\t\t%@ ", fight.name);
        
    }
    
    /*for (User *user in fetchedObjects) {
        // Log the label details
        
        NSLog(@"%@, %@ ", user.name, user.firstname);
        
        NSLog(@"\tA organisé la fight:");
        NSSet *fights = user.fights;
        for (Fight *fight in fights) {
            NSLog(@"\t\t%@ ", fight.name);
            
        }
    }*/
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"fight" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"fight.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
