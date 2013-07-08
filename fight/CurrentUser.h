//
//  CurrentUser.h
//  fight
//
//  Created by Benjamin on 08/07/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUser : NSObject {
    
    NSString *name;
    NSString *firstname;
    NSString * emmail;
    
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *firstname;
@property(nonatomic,retain)NSString *email;
+(CurrentUser*)getInstance;
@end
