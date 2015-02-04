//
//  BGSScheduleEventCell.h
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGSScheduleEventCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgEvent;

@property (weak, nonatomic) IBOutlet UIView *cellRed;
@property (weak, nonatomic) IBOutlet UIView *cellGreen;

@property (weak, nonatomic) NSString *strID;

@property (weak, nonatomic) NSString *strStatus;
// Need to manually call setup after setting status
- (void)setup;

@end
