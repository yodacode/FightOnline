//
//  Fight.h
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Fight : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * adminname;
@property (nonatomic, retain) NSDate * datefight;
@property (nonatomic, retain) NSNumber * fightersnumber;
@property (nonatomic, retain) NSNumber * fightersattending;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *users;
@end

@interface Fight (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
