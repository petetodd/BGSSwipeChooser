//
//  BGSSwipeFlowLayout.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSSwipeFlowLayout.h"
#import "BGSSwipeDecoration.h"
#import "BGSScheduleEventCell.h"

@implementation BGSSwipeFlowLayout
{
    int _offSet;
    CGSize _contentSize;
    // Size of image will be 70% of the available frame
    CGFloat _topFrameWidth;
    CGFloat _topFrameHeight;
    CGFloat _topFrameX;
    CGFloat _topFrameY;
    // Decoration Position
    CGFloat _xDecorationFrame;
    CGFloat _yDecorationFrame;

}

//const CGFloat ContentSizeWidth = 400;
const CGFloat TopBarHeight = 44;

//const CGFloat ContentSizeHeight = 500;


#pragma mark - UICollectionViewLayout Implementation

-(void)prepareLayout
{
    
    [self registerNib:[UINib nibWithNibName:@"BGSSwipeDecorationHeader" bundle:nil] forDecorationViewOfKind:@"BGSSwipeDecorationHeader"];
    [self registerNib:[UINib nibWithNibName:@"BGSSwipeDecoration" bundle:nil] forDecorationViewOfKind:@"BGSSwipeDecoration"];
    
    
    _contentSize = self.collectionView.frame.size;
    _topFrameWidth = _contentSize.width * 0.96;
    _topFrameHeight = (_contentSize.height - TopBarHeight - 50)  *0.60;
    _topFrameX = _contentSize.width * 0.02;
 //   _topFrameY = (_contentSize.height - 50) *0.05;
    _topFrameY = 50;

    _xDecorationFrame = 0;
    _yDecorationFrame =  (_contentSize.height - 120 - 50);


    
}

- (CGSize)collectionViewContentSize
{
    
    //CGSize contentSize = CGSizeMake(ContentSizeWidth, ContentSizeHeight);
    return _contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //[super layoutAttributesForElementsInRect:rect];
    _offSet = 0;

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
        NSLog(@"DEBUG calling layoutAttributesForItemAtIndexPath for event :%lu ",(unsigned long)indexPath.item);

        [layoutAttributes addObject:attributes];
    }
    
    NSLog(@"DEBUG visibleIndexPaths count :%lu ",(unsigned long)visibleIndexPaths.count);
   
#pragma mark - Decoration Views // Footer

    NSIndexPath *decorationIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    UICollectionViewLayoutAttributes *decorationAttributes =
    [UICollectionViewLayoutAttributes
     layoutAttributesForDecorationViewOfKind:@"BGSSwipeDecoration"
     withIndexPath:decorationIndexPath];
    
    decorationAttributes.frame = CGRectMake(_xDecorationFrame,
                                            _yDecorationFrame,
                                            414,
                                            120);
    decorationAttributes.zIndex = -1;

    
    [layoutAttributes addObject:decorationAttributes];
    
    
#pragma mark - Decoration Views // Footer
    
    UICollectionViewLayoutAttributes *decorationHeaderAttributes =
    [UICollectionViewLayoutAttributes
     layoutAttributesForDecorationViewOfKind:@"BGSSwipeDecorationHeader"
     withIndexPath:decorationIndexPath];
    
    decorationHeaderAttributes.frame = CGRectMake(0,
                                            0,
                                            414,
                                            50);
    decorationHeaderAttributes.zIndex = -1;

    [layoutAttributes addObject:decorationHeaderAttributes];

    
    

    
    
    
    
    
    
    
    return layoutAttributes;
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"BGSSwipeDecoration" withIndexPath:indexPath];
    layoutAttributes.frame = CGRectMake(0.0, 0.0, self.collectionViewContentSize.width, self.collectionViewContentSize.height);
    layoutAttributes.zIndex = -1;
    return layoutAttributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // [super layoutAttributesForItemAtIndexPath:indexPath];
    NSLog(@"DEBUG running layoutAttributesForItemAtIndexPath for event :%lu ",(unsigned long)indexPath.item);

    BGSSwipeDataSource *dataSource = (BGSSwipeDataSource *) self.collectionView.dataSource;
    id<BGSScheduleEvent> event = [dataSource eventAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    BGSScheduleEventCell *cell = (BGSScheduleEventCell *)  [self.collectionView cellForItemAtIndexPath:indexPath];
    attributes.zIndex = indexPath.item;

    if (self.isPanning &&(indexPath.row == self.selectedIndexPath.row))
    {
        CGRect frameUpdated = [self frameForPanningEvent:event];
        attributes.frame = frameUpdated;
        [self updateCellDisplay:cell frame:frameUpdated];
        
        
    }else
    {
        [cell.cellGreen setAlpha:0];
        [cell.cellRed setAlpha:0];

        attributes.frame = [self frameForEvent:event];
    }
    _offSet = _offSet + 10;

    return attributes;
}

#pragma mark - Helpers

- (NSArray *)indexPathsOfItemsInShow:(int)nbrItems
{
    NSLog(@"DEBUG indexPathsOfItemsInShow :%lu ",(unsigned long)nbrItems);

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
    
    frame.size.width = _topFrameWidth - (_offSet *2) ;
    //   frame.size.height = event.intDurationInHours * HeightPerHour;
    frame.size.height = _topFrameHeight;
    
  //  frame = CGRectInset(frame, 1, 0);
    return frame;
}
- (CGRect)frameForPanningEvent:(id<BGSScheduleEvent>)event
{
    CGRect frame = CGRectZero;
    
    // Always offset by the width of the y axis header
    frame.origin.x = _topFrameX + self.xPan;
    
    frame.origin.y = _topFrameY + self.yPan ;

    frame.size.width = _topFrameWidth ;
    frame.size.height = _topFrameHeight;
    
    return frame;
}

-(void)updateCellDisplay:(BGSScheduleEventCell *)cellSelected frame:(CGRect)frame
{
    // Update Red and Green indicators based on position of cell - more to the left then red, right green
    // Calculate the degree and direction of offset
    NSLog(@"DEBUG Frame center point: %f", CGRectGetMidX(self.collectionView.frame));
    
    NSLog(@"DEBUG Cell center point: %f", CGRectGetMidX(frame));
    // Gradually show the colour in the indicator view
    // Goes to max whne 50% at varience from centre
    if (CGRectGetMidX(frame) < CGRectGetMidX(self.collectionView.frame))
    {
        [cellSelected.cellGreen setAlpha:0];
        float percentageDiff = ((CGRectGetMidX(self.collectionView.frame) - CGRectGetMidX(frame)) / CGRectGetMidX(self.collectionView.frame));
        float roundedPercentageDiff = [[NSString stringWithFormat:@"%.1f",percentageDiff]floatValue];
        if (roundedPercentageDiff > 0.7)
        {
            [cellSelected.cellRed setAlpha:1];
            return;
            
        }

        if (roundedPercentageDiff <= 1)
        {
            [cellSelected.cellRed setAlpha:roundedPercentageDiff];
        }
        NSLog(@"DEBUG Cell red alpha : %f", cellSelected.cellRed.alpha);
    }else
    {
        [cellSelected.cellRed setAlpha:0];
        float percentageDiff = ((CGRectGetMidX(frame) - CGRectGetMidX(self.collectionView.frame)) / CGRectGetMidX(self.collectionView.frame));
        float roundedPercentageDiff = [[NSString stringWithFormat:@"%.1f",percentageDiff]floatValue];
        
        if (roundedPercentageDiff > 0.7                       )
        {
            [cellSelected.cellGreen setAlpha:1];
            return;
            
        }
        
        if (percentageDiff <= 1)
        {
            [cellSelected.cellGreen setAlpha:percentageDiff];
        }
        NSLog(@"DEBUG Cell green alpha : %f", cellSelected.cellGreen.alpha);
    }

    
    
}



@end
