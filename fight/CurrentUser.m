//
//  CurrentUser.m
//  fight
//
//  Created by Benjamin on 08/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import "CurrentUser.h"

@implementation CurrentUser
@synthesize name;
@synthesize firstname;
@synthesize email;


static CurrentUser *instance =nil;
+(CurrentUser *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [CurrentUser new];
        }
    }
    return instance;
}

@end
