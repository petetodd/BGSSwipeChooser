//
//  BGSSwipeCVC.m
//  BGSSwipeChooser
//
//  Created by Peter Todd Air on 02/02/2015.
//  Copyright (c) 2015 Bright Green Star. All rights reserved.
//

#import "BGSSwipeCVC.h"
#import "BGSScheduleEvent.h"
#import "BGSSwipeFlowLayout.h"

@interface BGSSwipeCVC ()

@end

@implementation BGSSwipeCVC
{
    CGFloat _xPan;
    CGFloat _yPan;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
  //  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self configGestures];
    BGSSwipeDataSource *dataSource = (BGSSwipeDataSource *)self.collectionView.dataSource;
    [dataSource generateStructuredSampleData:10];
    
    // Setup how the cell configure should run
    dataSource.configureCellBlock = ^(BGSScheduleEventCell *cell, NSIndexPath *indexPath, id<BGSScheduleEvent> event) {
        //   cell.titleLabel.text = event.strTitle;
        cell.titleLabel.text = [event.strTitle lowercaseString];
        cell.imgEvent.image = event.imgEvent;
        //NSLog(@"DEBUG configureCellBlock strStatus : %@",event.strStatus);
        [cell setup];
        
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Gestures
/*
 add a pan gesture to the collection view.  The action should allow the user to move the cell at highest index - basically
 move the image cell at the top of the pack.
 This should be more efficient then adding a Pan gesture to each cell
 */
-(void)configGestures
{
    UIPanGestureRecognizer *panOnCV = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPanOnCV:)];
    [self.view addGestureRecognizer:panOnCV];
}

-(void)actionPanOnCV:(UIPanGestureRecognizer *)panRecognizer
{
    NSLog(@"DEBUG Detected a Pan");
    CGPoint touchPoint = [panRecognizer locationInView: self.view];
    CGFloat x_increment;
    CGFloat y_increment;

    NSLog(@"DEBUG Location in view %f, %f",touchPoint.x,touchPoint.y);
    if (_xPan ==0)
    {
        _xPan = touchPoint.x;
        x_increment = 0;
    }else
    {
        x_increment = touchPoint.x - _xPan;
        _xPan = touchPoint.x;
    }
    
    if (_yPan ==0)
    {
        _yPan = touchPoint.y;
        y_increment = 0;
    }else
    {
        y_increment = touchPoint.y - _yPan;
        _yPan = touchPoint.y;
    }
    
//    [self.delegate postionInDU:self.strKeyDU duName:self.lblUnit.text  xPosition:touchPoint.x yPosition:touchPoint.y];
    
    // Get a reference to the flow layout
    BGSSwipeFlowLayout *flowLayout = (BGSSwipeFlowLayout *)self.collectionView.collectionViewLayout;
    [flowLayout setIsPanning:YES];
    [flowLayout setXPan:(flowLayout.xPan + x_increment)];
    [flowLayout setYPan:(flowLayout.yPan + y_increment)];
    // reference to datesource - used to get top index path
    BGSSwipeDataSource *dataSource = (BGSSwipeDataSource *)self.collectionView.dataSource;

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:([dataSource.events count] -1) inSection:0];
    [flowLayout setSelectedIndexPath:indexPath];
    [flowLayout layoutAttributesForItemAtIndexPath:indexPath];
    [flowLayout invalidateLayout];
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
