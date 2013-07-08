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
   [self create];
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;

    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];

    tabBarItem3.title = @"Fight";
    tabBarItem2.title = @"Profil";
    tabBarItem1.title = @"Accueil";
    
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"icon_gun_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_gun.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"icon_profile_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_profile.png"]];
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"home_active.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home.png"]];
    
    return YES;
}


- (void) create {
    // Grab the context
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    //test if data test exist
    if(matchingData.count <=0){
    
    
    //Create current user
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user.name = @"Nolimit";
    user.firstname = @"Fred";
    user.email = @"fred@gmail.com";
    user.password = @"abc123";
    user.age = [NSNumber numberWithInteger:23];
    user.profildescr = @"Initialement connu sous le nom de Cassius Clay, il change son nom en Mohamed Ali à l'âge de 22 ans après avoir rejoint la Nation of Islam en 1964 et se convertit par la suite à l'islam sunnite en 1975. En 1967, trois ans après avoir remporté le championnat des poids lourds, il a été publiquement vilipendé pour son refus d'être enrôlé dans l'armée américaine par opposition à la guerre du Vietnam et par croyances idéologiques";
    
    //Create user2
    User *user2 = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user2.name = @"Doe";
    user2.firstname = @"John";
    user2.email = @"jojo@gmail.com";
    user2.password = @"abc";
    user2.age = [NSNumber numberWithInteger:32];
    
    //Create user2
    User *user3 = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    user3.name = @"Stienne";
    user3.firstname = @"Edo";
    user3.email = @"edo@gmail.com";
    user3.password = @"bbb";
    user3.age = [NSNumber numberWithInteger:18];
    
    
    // Create a Default date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    NSDate *dateFight = [dateFormatter dateFromString:@"04/11/2014"];
    
    //create default places
    NSNumber * fightersNumber = [NSNumber numberWithInteger:15];
    NSNumber * fighterAttending = [NSNumber numberWithInt:1];
    NSNumber * fighterAttending2 = [NSNumber numberWithInt:2];
    
    //Create fight1
    Fight *fight = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
    fight.name = @"Street Baston";
    fight.address = @"28 rue Troyon Sevres France";
    fight.datefight = dateFight;
    fight.adminname = @"La fouine";
    fight.fightersnumber = fightersNumber;
    fight.fightersattending = fighterAttending;
    
    //Create fight 2
    Fight *fight2 = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
    fight2.name = @"PSG Fight";
    fight2.address = @"Trocadero Paris France";
    fight2.datefight = dateFight;
    fight2.adminname = @"Booba";
    fight2.fightersnumber = fightersNumber;
    fight2.fightersattending = fighterAttending2;
    
    //Create fight 3
    Fight *fight3 = [NSEntityDescription insertNewObjectForEntityForName:@"Fight" inManagedObjectContext:context];
    fight3.name = @"La sanglante";
    fight3.address = @"Chatelet les Halles Paris";
    fight3.adminname = @"Booba";
    fight3.datefight = dateFight;
    fight3.fightersnumber = fightersNumber;
    fight3.fightersattending = fighterAttending2;
    
    // Set relationships
    //[user addFightsObject:fight];
    //[fight addUsersObject:user];
    
    // Set relationships
    [user addFights:[NSSet setWithObjects:fight, nil]];
    [user2 addFights:[NSSet setWithObjects:fight2, fight3, nil]];
    [user3 addFights:[NSSet setWithObjects:fight2, fight3, nil]];
    //[user addFights:[NSSet setWithObject:fight,fight2,nil]];

    
    // Save everything
    NSError *error = nil;
    if ([context save:&error]) {
        NSLog(@"The save was successful!");
    } else {
        NSLog(@"The save wasn't successful: %@", [error userInfo]);
    }
        
    }
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
