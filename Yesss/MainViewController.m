//
//  ViewController.m
//  Yesss
//
//  Created by Tim on 02/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UIView *boardView;
@property (nonatomic, weak) IBOutlet UIView *pieceView;
@property (nonatomic, strong) UIView *panningView;
@property (nonatomic, strong) NSMutableArray *piecesOnBoardArray;

@property (nonatomic, strong) NSMutableArray *boardArray;

@property (nonatomic) CGSize cellSize;
@property (nonatomic) CGSize pieceSize;

@property (nonatomic, weak) IBOutlet UILabel *xCoord;
@property (nonatomic, weak) IBOutlet UILabel *yCoord;
@end

#define kCellBorderWidth 1.0f
#define kStatusBarOffsetValue 20.0f
#define kPieceWidthMultiplier 1.0f
#define kPieceHeightMultiplier 1.0f

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setupBoard];
    [self drawBoard];
    [self setupPieces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Board methods

-(void)drawBoard {
    
    NSUInteger boardHeight = self.view.frame.size.height - 20;
    NSUInteger boardWidth = boardHeight;
    
    [self.boardView setFrame:CGRectMake(0, kStatusBarOffsetValue, boardWidth, boardHeight)];
    
    self.cellSize = CGSizeMake(boardHeight/10, boardHeight/10);
    
    self.pieceSize = CGSizeMake(self.cellSize.width * kPieceWidthMultiplier, self.cellSize.height * kPieceHeightMultiplier);
    
    // Draw rows
    for (int row = 0; row < 10; row++) {
        
        // Draw columns
        for (int col = 0; col < 10; col++) {
            
            CGFloat xPosition = col * self.cellSize.width;
            CGFloat yPosition = row * self.cellSize.height;
            
            UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(xPosition, yPosition, self.cellSize.width, self.cellSize.height)];
            
            cellView.layer.borderColor = [UIColor blackColor].CGColor;
            cellView.layer.borderWidth = kCellBorderWidth;

            // Check if cell should be occupied
            int currentRowValue = [[self.boardArray objectAtIndex:row] intValue];
            
            int currentColumnInt = pow(2, col);
            
            // AND the two together
            int result = currentRowValue & currentColumnInt;
            
            if (result == currentColumnInt) {
                [cellView setBackgroundColor:[UIColor redColor]];
            } else {
                [cellView setBackgroundColor:[UIColor clearColor]];
            }

            [self.boardView addSubview:cellView];
            
        }
        
    }
    
    [self.xCoord setText:@"-"];
    [self.yCoord setText:@"-"];
    
}

-(void)setupPieces {
    
    self.piecesOnBoardArray = [[NSMutableArray alloc] init];

    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    [self.pieceView addGestureRecognizer:panRecognizer];

}

-(void)setupBoard {
    
    NSArray *boardLayout = @[@512, @256, @128, @128, @37, @29, @14, @0, @12, @4];
    self.boardArray = [boardLayout mutableCopy];
    
}

#pragma mark -
#pragma mark Interaction methods

-(IBAction)didPanPiece:(id)sender {
    
    UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)sender;
    
    CGPoint fingerLocation = [panRecognizer locationInView:self.view];

    // Add view
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        
        // Add moving piece to the board
        [self addPanningPieceToBoard];
        
    }
    
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        
        [self movePanningPieceToFingerLocation:fingerLocation];
        
    }
    
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [self dropPanningPieceAtLocation:fingerLocation];
        
    }
    
}

-(IBAction)didTapToRemovePieceFromBoard:(id)sender {
    // Place moving piece
    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer *)sender;
    
    UIView *tappedView = recognizer.view;
    
    [self.piecesOnBoardArray removeObject:tappedView];
    [tappedView removeFromSuperview];
    tappedView = nil;
    
}

#pragma mark -
#pragma mark Panning methods

-(void)addPanningPieceToBoard {

    self.panningView = [[UIView alloc] initWithFrame:CGRectMake(self.pieceView.frame.origin.x,
                                                                self.pieceView.frame.origin.y,
                                                                self.pieceSize.width - 2,
                                                                self.pieceSize.height -2)];
    [self.panningView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.panningView];

}

-(void)movePanningPieceToFingerLocation:(CGPoint)fingerLocation {

    [self.xCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.x]];
    [self.yCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.y]];

    [self.panningView setFrame:CGRectMake(fingerLocation.x, fingerLocation.y, self.panningView.frame.size.width, self.panningView.frame.size.height)];

}

-(void)dropPanningPieceAtLocation:(CGPoint)fingerLocation {
    
    CGPoint constrainedDropPoint = [self calculateConstrainedDropPointForLocation:fingerLocation];

    if ([self checkForIllegalDropLocation:constrainedDropPoint]) {
        // Cannot drop piece at this location,
        // animate it back to the starting point
        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{

                             [self.panningView setFrame:CGRectMake(self.pieceView.frame.origin.x,
                                                                   self.pieceView.frame.origin.y,
                                                                   self.panningView.frame.size.width,
                                                                   self.panningView.frame.size.height)];

                         } completion:^(BOOL finished) {
                             
                             [self.panningView removeFromSuperview];
                             self.panningView = nil;
                             
                         }];
        
        return;
    }

    // Check for existing piece at this location
    if ([self checkForOccupiedDropLocation:constrainedDropPoint]) {
        // Cannot drop piece at this location,
        // animate it back to the starting point
        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             [self.panningView setFrame:CGRectMake(self.pieceView.frame.origin.x,
                                                                   self.pieceView.frame.origin.y,
                                                                   self.panningView.frame.size.width,
                                                                   self.panningView.frame.size.height)];
                             
                         } completion:^(BOOL finished) {
                             
                             [self.panningView removeFromSuperview];
                             self.panningView = nil;
                             
                         }];
        
        return;
    }

    
    // Drop piece on board
    UIView *droppedPiece = [[UIView alloc] initWithFrame:self.panningView.frame];
    [droppedPiece setBackgroundColor:self.panningView.backgroundColor];

    // Constrain location
    [droppedPiece setFrame:CGRectMake(constrainedDropPoint.x + kCellBorderWidth,
                                      constrainedDropPoint.y + kCellBorderWidth ,
                                      droppedPiece.frame.size.width,
                                      droppedPiece.frame.size.height)];

    [self.view addSubview:droppedPiece];
    [self.piecesOnBoardArray addObject:droppedPiece];

    // Add gesture recognizer to piece to allow removal
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapToRemovePieceFromBoard:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [droppedPiece addGestureRecognizer:tapRecognizer];

    [self.panningView removeFromSuperview];
    self.panningView = nil;

    [self.xCoord setText:@"-"];
    [self.yCoord setText:@"-"];
    
}



#pragma mark -
#pragma mark Calculation methods

-(CGPoint)calculateConstrainedDropPointForLocation:(CGPoint)fingerLocation {
    
    float droppedCellX = fingerLocation.x / self.cellSize.width;
    float droppedCellY = fingerLocation.y / self.cellSize.height;
    
    float modX = floorf(droppedCellX);
    float modY = floorf(droppedCellY);
    
    NSInteger newXLocation = modX * self.cellSize.width;
    NSInteger newYLocation = modY * self.cellSize.height + kStatusBarOffsetValue; // offset 20 to account for status bar
    
    return CGPointMake(newXLocation, newYLocation);
    
}

-(BOOL)checkForIllegalDropLocation:(CGPoint)constrainedDropPoint {
    
    // Check if dropped piece extends beyond board boundaries
    float rightEdgeOfPiece = constrainedDropPoint.x + self.pieceSize.width;
    
    if (rightEdgeOfPiece > (self.boardView.frame.size.width)) {
        return YES;
    }
    
    // Calculate bottom edge of peice and adjust for status bar offset
    float bottomEdgeOfPiece = constrainedDropPoint.y + self.pieceSize.height - kStatusBarOffsetValue;

    if (bottomEdgeOfPiece > (self.boardView.frame.size.height)) {
        return YES;
    }
    
    // Piece does not extend beyond board boundaries
    
    return NO;
}

-(BOOL)checkForOccupiedDropLocation:(CGPoint)constrainedDropPoint {
    
    // Convert finger location to cell
    int droppedRow = [self calculateRowNumberForConstrainedDropPoint:constrainedDropPoint];
    int droppedCol = [self calculateColNumberForConstrainedDropPoint:constrainedDropPoint];
    
    // Check if there's a piece at this location
    // Get row from board array
    
    // Check if cell is occupied
    int currentRowValue = [[self.boardArray objectAtIndex:droppedCol] intValue];
    int currentColumnInt = pow(2, droppedRow);
    
    // AND the two together
    int result = currentRowValue & currentColumnInt;
    
    if (result == currentColumnInt) {
        NSLog(@"The cell is occuplied");
        return YES;
    } else {
        NSLog(@"the cell is empty");
        return NO;
    }

}

-(int)calculateRowNumberForConstrainedDropPoint:(CGPoint)constrainedDropPoint {
    
    float xPosition = constrainedDropPoint.x;
    return (xPosition / self.cellSize.height);
    
}

-(int)calculateColNumberForConstrainedDropPoint:(CGPoint)constrainedDropPoint {
    float yPosition = constrainedDropPoint.y;
    return (yPosition / self.cellSize.width);
}

@end
