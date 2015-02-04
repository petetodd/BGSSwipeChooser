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


@property (assign, nonatomic) NSInteger intUnitOrder; // Used for internal sorting


@property (strong, nonatomic) UIImage  *imgEvent;




@end
