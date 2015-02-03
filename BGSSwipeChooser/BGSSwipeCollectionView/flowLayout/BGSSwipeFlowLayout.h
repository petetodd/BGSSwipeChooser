//
//  BGSSwipeFlowLayout.h
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGSSwipeDataSource.h"
#import "BGSScheduleEvent.h"

@interface BGSSwipeFlowLayout : UICollectionViewFlowLayout
@property CGFloat xPan;
@property CGFloat yPan;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property BOOL isPanning;
@end
