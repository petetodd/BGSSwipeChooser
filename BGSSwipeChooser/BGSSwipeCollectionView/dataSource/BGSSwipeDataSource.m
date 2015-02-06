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
    
    [UIImage imageNamed:@"bird1.png"];
    for (int i = 0; i < nbrDataPoints; i++)
    {
        // Create the event
        NSString *strTitle = [NSString stringWithFormat:@"Other %i ",i];
        if (i ==0)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Bird 0" image:[UIImage imageNamed:@"bird1.png"]];
            [self.events addObject:event];
        }else if (i ==1)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"A lake 1" image:[UIImage imageNamed:@"lake1.png"]];
            [self.events addObject:event];
        }
        else if (i ==2)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Cat 2" image:[UIImage imageNamed:@"cat1.png"]];
            [self.events addObject:event];
        }else if (i ==3)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Cat 3" image:[UIImage imageNamed:@"cat2.png"]];
            [self.events addObject:event];
        }else if (i ==4)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Seal 4" image:[UIImage imageNamed:@"seal1.png"]];
            [self.events addObject:event];
        }else if (i ==5)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Bird 5" image:[UIImage imageNamed:@"bird1.png"]];
            [self.events addObject:event];
        }else if (i ==6)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"fossil 6" image:[UIImage imageNamed:@"fossil1.png"]];
            [self.events addObject:event];
        }else if (i ==7)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"more lake 7" image:[UIImage imageNamed:@"lake2.png"]];
            [self.events addObject:event];
        }else if (i ==8)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Lizard 8" image:[UIImage imageNamed:@"lizard1.png"]];
            [self.events addObject:event];
        }else if (i ==9)
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:@"Australia 9" image:[UIImage imageNamed:@"roo1.png"]];
            [self.events addObject:event];
        } else
        {
            BGSSampleScheduleEvent *event = [BGSSampleScheduleEvent eventWithTitle:strTitle image:[UIImage imageNamed:@"bird1.png"]];
            [self.events addObject:event];
        }
        
        
    }
    
}


#pragma mark - FlowLayout Support

- (NSArray *)indexPathsOfEventsDepthToShow:(int)intDepth
{
    NSMutableArray *mutArray = [[NSMutableArray alloc]init];
    NSLog(@"DEBUG EVENT COUNT :%lu ",(unsigned long)self.events.count);

    // Need to calculate the depth to show as if we stat with 10 and show a depth of 3, whne we get under 3 we'll through an out of array error.
    int intDepthUpd = intDepth;
    if (self.events.count < intDepth)
    {
        intDepthUpd =  (int)self.events.count;
    }
    
    
    long intCt = self.events.count - 1;
    for (long i = intCt; ((i >= (self.events.count - intDepthUpd)) && (i >= 0)); i--)
    {
        NSLog(@"DEBUG OBJECT AT INDEX :%lu ",i);

        if ([self.events objectAtIndex:i])
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];

            [mutArray addObject:indexPath];
            NSLog(@"DEBUG indexPathsOfEventsDepthToShow selected event index: :%lu ",i);

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
    NSLog(@"DEBUG eventAtIndexPath :%lu ",indexPath.item);

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
    NSLog(@"DEBUG cellForItemAtIndexPath  index: :%lu ",indexPath.item);
    

    
    id<BGSScheduleEvent> event = self.events[indexPath.item];
    BGSScheduleEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier  forIndexPath:indexPath];
    
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    
    return cell;
}


@end
