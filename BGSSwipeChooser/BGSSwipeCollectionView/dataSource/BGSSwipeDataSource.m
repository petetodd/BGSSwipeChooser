//
//  BGSSwipeDataSource.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSSwipeDataSource.h"
#import "BGSSampleScheduleEvent.h"


@implementation BGSSwipeDataSource
static NSString * const reuseIdentifier = @"Cell";


#pragma mark <UICollectionViewDataSource>

- (void)awakeFromNib
{
    self.events = [[NSMutableArray alloc] init];
    
    // Prepare some example events
    // [self generateStructuredSampleData:10];
    
    
}


- (void)generateStructuredSampleData:(int)nbrDataPoints
{
    
    [UIImage imageNamed:@"peter_hike.png"];
    for (int i = 0; i < nbrDataPoints; i++)
    {
        // Create the event
        NSString *strTitle = [NSString stringWithFormat:@"Other %i ",i];
        if (i ==0)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Hiking" image:[UIImage imageNamed:@"peter_hike.png"]];
            [self.events addObject:event];
        }else if (i ==2)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Cold" image:[UIImage imageNamed:@"Peter_cold.png"]];
            [self.events addObject:event];
        }else if (i ==3)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Flower" image:[UIImage imageNamed:@"Peter_flower.png"]];
            [self.events addObject:event];
        }else if (i ==4)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"More hiking" image:[UIImage imageNamed:@"peter_hike.png"]];
            [self.events addObject:event];
        }else if (i ==5)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Lookalike" image:[UIImage imageNamed:@"Peter_lookalike.png"]];
            [self.events addObject:event];
        } else
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:strTitle image:[UIImage imageNamed:@"Peter_lookalike.png"]];
            [self.events addObject:event];
        }
        
        
    }
    
}


#pragma mark - FlowLayout Support

- (NSArray *)indexPathsOfEventsDepthToShow:(int)intDepth
{
    NSMutableArray *mutArray = [[NSMutableArray alloc]init];
    long intCt = self.events.count - 1;
    for (long i = intCt; i >= (self.events.count - intDepth); i--)
    {
        if ([self.events objectAtIndex:i])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

            [mutArray addObject:indexPath];
        }
    }
    NSLog(@"DEBUG mutArray visibleIndexPaths count :%lu ",(unsigned long)mutArray.count);

    return mutArray;
}


#pragma mark - FlowLayout DataSource

// The layout object calls these methods to identify the events that correspond to
// a given index path or that are visible in a certain rectangle

- (id<BGSScheduleEvent>)eventAtIndexPath:(NSIndexPath *)indexPath
{
    return self.events[indexPath.item];
}

#pragma mark - UICollectionViewDataSource



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.events count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  //  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    id<BGSScheduleEvent> event = self.events[indexPath.item];
    BGSScheduleEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier  forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    
    return cell;
}


@end
