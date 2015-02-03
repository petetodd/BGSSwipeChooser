//
//  BGSScheduleEventCell.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSScheduleEventCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation BGSScheduleEventCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
 //   CALayer *leftBorder = [CALayer layer];
 //   leftBorder.frame = CGRectMake(0.0f, 0.0f,2.0f,self.frame.size.height);
    
    
    
      self.layer.cornerRadius = 10;
      self.layer.borderWidth = 0.1;
      self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0.7 alpha:1] CGColor];

   //     leftBorder.backgroundColor = [UIColor blueColor].CGColor;
        self.backgroundColor = [UIColor orangeColor];
//    [self.layer addSublayer:leftBorder];
}

@end
