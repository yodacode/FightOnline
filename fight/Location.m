//
//  Location.m
//  fight
//
//  Created by Benjamin on 24/06/13.
//  Copyright (c) 2013 Benjamin. All rights reserved.
//
#import "Location.h"


@interface Annotation : NSObject <MKAnnotation> {
    NSString *_title;
    NSString *_subtitle;
    
    CLLocationCoordinate2D _coordinate;
}

// Getters and setters
- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;

@end

