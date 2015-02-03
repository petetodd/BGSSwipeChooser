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
@synthesize strSubTitle = _subTitle;
@synthesize strStatus = _status;
@synthesize strID = _strID;
@synthesize strStarttime = _startTime;



@synthesize intUnitOrder = _unitOrder;
@synthesize intDay = _day;
@synthesize intStartMinute = _startMinute;
@synthesize intDurationInMinutes = _durationInMinutes;
@synthesize timeSlotStartTime = _timeSlotStartTime;

@synthesize strUnitKey = _strUnitKey;
@synthesize strReferencekey = _strReferencekey;
@synthesize strCustomerName = _strCustomerName;
@synthesize strMatchDesc = _strMatchDesc;
@synthesize strMatchAddress = _strMatchAddress;
@synthesize eventRating = _eventRating;

@synthesize strCustomerPhone = _strCustomerPhone;
@synthesize strCustomerEmail = _strCustomerEmail;
@synthesize strEventBlob = _strMatchBlob;
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
    return [NSString stringWithFormat:@"Title: %@, %ld : D:%ld H:%ld L:%ld",self.strTitle, (long)self.intUnitOrder, (long)self.intDay, (long)self.intStartMinute, (long)self.intDurationInMinutes];
}



@end
