//
//  User.h
//  fight
//
//  Created by Benjamin on 01/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *fights;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFightsObject:(NSManagedObject *)value;
- (void)removeFightsObject:(NSManagedObject *)value;
- (void)addFights:(NSSet *)values;
- (void)removeFights:(NSSet *)values;

@end
