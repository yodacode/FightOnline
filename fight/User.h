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

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * firstname;

@end

@interface User (CoreDataGeneratedAccessors)

@end