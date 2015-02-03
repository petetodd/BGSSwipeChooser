//
//  BGSScheduleEvent.h
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol BGSScheduleEvent <NSObject>

@property (copy, nonatomic) NSString *strTitle;
@property (copy, nonatomic) NSString *strSubTitle;


@property (copy, nonatomic) NSString *strStatus;
@property (copy, nonatomic) NSString *strID;
@property (copy, nonatomic) NSString *strStarttime;



@property (assign, nonatomic) NSInteger intUnitOrder; // Used for internal sorting
@property (assign, nonatomic) NSInteger intDay;
@property (assign, nonatomic) NSInteger intStartMinute;
@property (assign, nonatomic) NSInteger intDurationInMinutes;
@property (copy, nonatomic) NSString * timeSlotStartTime;
@property (copy, nonatomic) NSString * eventRating;

@property (copy, nonatomic) NSString *strUnitKey;
@property (copy, nonatomic) NSString *strReferencekey;
@property (copy, nonatomic) NSString *strCustomerName;
@property (copy, nonatomic) NSString *strMatchDesc;
@property (copy, nonatomic) NSString *strMatchAddress;
@property (copy, nonatomic) NSString *strCustomerPhone;
@property (copy, nonatomic) NSString *strCustomerEmail;
@property (copy, nonatomic) NSString *strEventBlob;

@property (strong, nonatomic) UIImage  *imgEvent;




@end
