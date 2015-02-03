//
//  BGSSampleScheduleEvent.h
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGSScheduleEvent.h"


@interface BGSSampleScheduleEvent : NSObject <BGSScheduleEvent>

+ (instancetype)eventWithTitle:(NSString *)title image:(UIImage *)imgEvent;


@end
