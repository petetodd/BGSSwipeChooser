//
//  BGSSwipeFlowLayout.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSSwipeFlowLayout.h"

@implementation BGSSwipeFlowLayout
{
    int _offSet;
    CGSize _contentSize;
    // Size of image will be 70% of the available frame
    CGFloat _topFrameWidth;
    CGFloat _topFrameHeight;
    CGFloat _topFrameX;
    CGFloat _topFrameY;

}

//const CGFloat ContentSizeWidth = 400;
const CGFloat TopBarHeight = 44;

//const CGFloat ContentSizeHeight = 500;


#pragma mark - UICollectionViewLayout Implementation

-(void)prepareLayout
{
    _contentSize = self.collectionView.frame.size;
    _topFrameWidth = _contentSize.width * 0.70;
    _topFrameHeight = (_contentSize.height - TopBarHeight)  *0.70;
    _topFrameX = _contentSize.width * 0.15;
    _topFrameY = (_contentSize.height - TopBarHeight) *0.05;


    
}

- (CGSize)collectionViewContentSize
{
    
    //CGSize contentSize = CGSizeMake(ContentSizeWidth, ContentSizeHeight);
    return _contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    _offSet = 0;
    // Super will return all the attributes including cells that are not visible.
    // But not visible cells will not be draw correctly and will appear at 0,0 - messy and memory intensive
    //   NSMutableArray *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableArray *layoutAttributes = [[NSMutableArray alloc]init];
    
    
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    
    //NSLog(@"DEBUG rect size : %f,%f,%f,%f ",rect.size.height,rect.size.width, rect.origin.x, rect.origin.y);
    //NSLog(@"DEBUG rect visi : %f,%f,%f,%f ",visibleRect.size.height,visibleRect.size.width, visibleRect.origin.x, visibleRect.origin.y);
    
    
    // Cells
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInShow:3];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
    
    NSLog(@"DEBUG visibleIndexPaths count :%lu ",(unsigned long)visibleIndexPaths.count);
    
    
    return layoutAttributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _offSet = _offSet + 10;
    BGSSwipeDataSource *dataSource = (BGSSwipeDataSource *) self.collectionView.dataSource;
    id<BGSScheduleEvent> event = [dataSource eventAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (self.isPanning &&(indexPath.row == self.selectedIndexPath.row))
    {
        attributes.frame =[self frameForPanningEvent:event];
    }else
    {
        attributes.frame = [self frameForEvent:event];
    }
    return attributes;
}

#pragma mark - Helpers

- (NSArray *)indexPathsOfItemsInShow:(int)nbrItems
{
    /*
     The aim is to show a most 3 overlapping cell - like a pack of card where you can just see the edge of 3 cards and rest of the pack isn't visible.  As the user dicards the top card then the bottom cell will retpresent the 3rd card down in the pack
     
     */
    BGSSwipeDataSource *dataSource = (BGSSwipeDataSource *) self.collectionView.dataSource;
    
    NSArray *indexPaths = [dataSource indexPathsOfEventsDepthToShow:nbrItems];    //    return nil;
    
    
    return indexPaths;
}

- (CGRect)frameForEvent:(id<BGSScheduleEvent>)event
{
    //   CGFloat totalWidth = [self collectionViewContentSize].width - WidthPerMinute;
    //  CGFloat widthPerDay = totalWidth / DaysPerWeek;
    //   CGFloat widthPerDay = 100;
    
    CGRect frame = CGRectZero;

    // Center and then offset as required
    
    // Always offset by the width of the y axis header
    frame.origin.x = _topFrameX + _offSet;
    
    //   frame.origin.y = (event.intDeliveryUnit * HeightPerDU) - HeightPerDU;
    frame.origin.y = _topFrameY + _offSet ;
 //   frame.origin.y = 10 ;

    //  frame.size.width = widthPerDay;
    
    frame.size.width = _topFrameWidth ;
    //   frame.size.height = event.intDurationInHours * HeightPerHour;
    frame.size.height = _topFrameHeight;
    
  //  frame = CGRectInset(frame, 1, 0);
    return frame;
}
- (CGRect)frameForPanningEvent:(id<BGSScheduleEvent>)event
{
    CGRect frame = CGRectZero;
    
    // Always offset by the width of the y axis header
    frame.origin.x = self.xPan;
  //  frame.origin.x = _topFrameX + _offSet;

    
    frame.origin.y = self.yPan ;
 //   frame.origin.y = _topFrameY + _offSet ;


    frame.size.width = _topFrameWidth ;
    frame.size.height = _topFrameHeight;
    
    return frame;
}




@end
