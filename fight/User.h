//
//  User.h
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Fight;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * profildescr;
@property (nonatomic, retain) NSSet *fights;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFightsObject:(Fight *)value;
- (void)removeFightsObject:(Fight *)value;
- (void)addFights:(NSSet *)values;
- (void)removeFights:(NSSet *)values;

@end
