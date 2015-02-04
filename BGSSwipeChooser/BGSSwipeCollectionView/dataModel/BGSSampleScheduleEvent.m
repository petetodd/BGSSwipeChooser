//
//  BGSSampleScheduleEvent.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSSampleScheduleEvent.h"

@implementation BGSSampleScheduleEvent
// Note :Auto property synthesise will not synthesise properties declared in a protocol

@synthesize strTitle = _title;


@synthesize intUnitOrder = _unitOrder;

@synthesize imgEvent = _imgEvent;



+ (instancetype)eventWithTitle:(NSString *)title image:(UIImage *)imgEvent
{
    return [[self alloc] initWithTitle:title image:imgEvent];
}


- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)imgEvent
{
    self = [super init];
    if (self != nil) {
        _title = [title copy];
        _imgEvent = imgEvent;

        _title = [self description];
        
    }
    return self;
}

/*
 Returns a string that describes the contents of the receiver. (required)
 This method is used to create a textual representation of an object, for example in a formatted string:
 */

- (NSString *)description
{
    return [NSString stringWithFormat:@"Title: %@, %ld",self.strTitle, (long)self.intUnitOrder];
}



@end
