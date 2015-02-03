//
//  BGSSwipeDataSource.h
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BGSScheduleEventCell.h"
#import "BGSScheduleEvent.h"




typedef void (^ConfigureCellBlock)(BGSScheduleEventCell *cell, NSIndexPath *indexPath, id<BGSScheduleEvent> event);


@interface BGSSwipeDataSource : NSObject

@property (strong, nonatomic) NSMutableArray *events;

@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;

- (void)generateStructuredSampleData:(int)nbrDataPoints;

- (NSArray *)indexPathsOfEventsDepthToShow:(int)intDepth;


- (id<BGSScheduleEvent>)eventAtIndexPath:(NSIndexPath *)indexPath;


@end
