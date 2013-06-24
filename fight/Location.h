//
//  Location.h
//  fight
//
//  Created by Benjamin on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject  {
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end