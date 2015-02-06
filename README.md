# BGSSwipeChooser
A swipe chooser implemented using UICollectionView. (inspired by Tinder style apps)

The images are displayed as a stack and you just swipe off the top.  As you swipe to the left (discard) an indicator gets progressively redder and to the right (like) progressively greener.  Enabling this requires a custom UICollectionViewFlowLayout.  

The main advantage was to use UICollectionView datasource to manage the data side.  In the live implementation the data is sourced from a remote server, in this demo its just some hardcoded example data.

The app displays a chooser that allows you to swipe left or right to discard or like the image.  As you discard the next image is displayed.


