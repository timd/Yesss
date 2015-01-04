//
//  ViewController.m
//  Yesss
//
//  Created by Tim on 02/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Piece.h"
#import "PieceFactory.h"

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UIView *boardView;
@property (nonatomic, weak) IBOutlet UIView *templatePieceOne;
@property (nonatomic, weak) IBOutlet UIView *templatePieceTwo;
@property (nonatomic, weak) IBOutlet UIView *templatePieceThree;
@property (nonatomic, weak) IBOutlet UIView *templatePieceFour;
@property (nonatomic, weak) IBOutlet UIView *templatePieceFive;

@property (nonatomic, strong) UIView *panningView;
@property (nonatomic, strong) NSMutableArray *piecesArray;
@property (nonatomic, strong) NSMutableArray *piecesOnBoardArray;

@property (nonatomic, strong) NSMutableArray *boardArray;

@property (nonatomic, strong) Piece *pieceBeingMoved;
@property (nonatomic) BOOL shouldCancelPiecePlacement;

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
    
    // Remove any existing subviews
    for (UIView *view in self.boardView.subviews) {
        [view removeFromSuperview];
    }
    
    // Draw rows
    for (int row = 0; row < 10; row++) {
        
        NSMutableArray *rowArray = [self.boardArray objectAtIndex:row];
        
        // Draw columns
        for (int col = 0; col < 10; col++) {
            
            CGFloat xPosition = col * self.cellSize.width;
            CGFloat yPosition = row * self.cellSize.height;
            
            UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(xPosition, yPosition, self.cellSize.width, self.cellSize.height)];
            
            cellView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cellView.layer.borderWidth = kCellBorderWidth;
            
            // Check if cell should be occupied
            int currentRowValue = [[rowArray objectAtIndex:col] intValue];

            UIColor *backgroundColor = nil;
            float cornerRadius = cellView.frame.size.width / 2;
            
            switch (currentRowValue) {
                case 1:
                    backgroundColor = [UIColor redColor];
                    break;

                case 2:
                    backgroundColor = [UIColor blueColor];
                    break;

                case 3:
                    backgroundColor = [UIColor greenColor];
                    break;

                case 4:
                    backgroundColor = [UIColor purpleColor];
                    break;

                case 5:
                    backgroundColor = [UIColor brownColor];
                    break;
                    
                case 99:
                    backgroundColor = [UIColor lightGrayColor];
                    cornerRadius = 0;
                    break;

                default:
                    backgroundColor = [UIColor clearColor];
                    break;
            }
            
            // Create blob and insert
            UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellView.frame.size.width, cellView.frame.size.height)];
            [circleView setBackgroundColor:backgroundColor];
            circleView.layer.cornerRadius = cornerRadius;
            [cellView addSubview:circleView];
            
            // Colour block
            [self.boardView addSubview:cellView];
            
        }
        
    }
    
    [self.xCoord setText:@"-"];
    [self.yCoord setText:@"-"];
    
}

-(void)setupPieces {
    
    PieceFactory *factory = [[PieceFactory alloc] init];
    self.piecesArray = [[factory setOfPieces] mutableCopy];

}

-(void)setupBoard {
    
    NSMutableArray *row0 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row1 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@99] mutableCopy];
    NSMutableArray *row2 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@99,@99] mutableCopy];
    NSMutableArray *row3 = [@[@0,@0,@0,@0,@0,@0,@0,@99,@99,@99] mutableCopy];
    NSMutableArray *row4 = [@[@0,@0,@0,@0,@0,@0,@99,@99,@99,@99] mutableCopy];
    NSMutableArray *row5 = [@[@0,@0,@0,@0,@0,@99,@99,@99,@99,@99] mutableCopy];
    NSMutableArray *row6 = [@[@0,@0,@0,@0,@99,@99,@99,@99,@99,@99] mutableCopy];
    NSMutableArray *row7 = [@[@0,@0,@0,@99,@99,@99,@99,@99,@99,@99] mutableCopy];
    NSMutableArray *row8 = [@[@0,@0,@99,@99,@99,@99,@99,@99,@99,@99] mutableCopy];
    NSMutableArray *row9 = [@[@0,@99,@99,@99,@99,@99,@99,@99,@99,@99] mutableCopy];
    
    NSArray *boardLayout = @[row0, row1, row2, row3, row4, row5, row6, row7, row8, row9];
    self.boardArray = [boardLayout mutableCopy];
    
    UIPanGestureRecognizer *panRecognizerOne = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    UIPanGestureRecognizer *panRecognizerTwo = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    UIPanGestureRecognizer *panRecognizerThree = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    UIPanGestureRecognizer *panRecognizerFour = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    UIPanGestureRecognizer *panRecognizerFive = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanPiece:)];
    
    [self.templatePieceOne addGestureRecognizer:panRecognizerOne];
    [self.templatePieceTwo addGestureRecognizer:panRecognizerTwo];
    [self.templatePieceThree addGestureRecognizer:panRecognizerThree];
    [self.templatePieceFour addGestureRecognizer:panRecognizerFour];
    [self.templatePieceFive addGestureRecognizer:panRecognizerFive];

    // Set up tap catcher to remove piece from board
    UITapGestureRecognizer *pieceRemover = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapToRemovePieceFromBoard:)];
    [pieceRemover setNumberOfTapsRequired:1];
    [pieceRemover setNumberOfTouchesRequired:1];
    
    [self.boardView addGestureRecognizer:pieceRemover];
    
    self.piecesOnBoardArray = [[NSMutableArray alloc] init];
    
    
}

#pragma mark -
#pragma mark Setup methods

-(void)setupShapes {
    
}

#pragma mark -
#pragma mark Interaction methods

-(IBAction)didPanPiece:(id)sender {
    
    UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)sender;
    UIView *sendingView = panRecognizer.view;
    NSUInteger tag = sendingView.tag;
    
    CGPoint fingerLocation = [panRecognizer locationInView:self.view];

    // Add view
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {

        [self addPanningPieceToBoardWithPieceNumber:tag];

    }
    
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        
        [self movePanningPieceToFingerLocation:fingerLocation];
        
    }
    
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [self dropPanningPieceAtLocation:fingerLocation];
        
    }
    
}

-(IBAction)didTapToRemovePieceFromBoard:(id)sender {
    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer *)sender;
    CGPoint tappedPoint = [recognizer locationInView:self.boardView];

    CGPoint constrainedDropPoint = [self calculateConstrainedDropPointForLocation:tappedPoint];

    int droppedRow = [self calculateRowNumberForConstrainedDropPoint:constrainedDropPoint];
    int droppedCol = [self calculateColNumberForConstrainedDropPoint:constrainedDropPoint];

    NSMutableArray *droppedRowArray = [self.boardArray objectAtIndex:droppedRow];
    NSNumber *pieceType = [droppedRowArray objectAtIndex:droppedCol];
    
    if ([pieceType isEqualToNumber:@0]) {
        // cell is empty
        return;
    }
    
    // Iterate across all rows and cols to remove pieces of this type
    for (NSMutableArray *rowArray in self.boardArray) {
        
        for (int col = 0; col < [rowArray count]; col++) {
            
            NSNumber *cellContents = [rowArray objectAtIndex:col];
            
            if ([cellContents isEqualToNumber:pieceType]) {
                [rowArray replaceObjectAtIndex:col withObject:@0];
            }
            
        }
        
    }
    
    // Find and remove the piece from the piecesOnBoard array
    NSUInteger indexOfPieceToRemove = [self.piecesOnBoardArray indexOfObjectPassingTest:^BOOL(Piece *piece, NSUInteger idx, BOOL *stop) {
        return (piece.shapeId == [pieceType integerValue]);
    }];
    
    if (indexOfPieceToRemove != NSNotFound) {
        [self.piecesOnBoardArray removeObjectAtIndex:indexOfPieceToRemove];
    }
    
    [self drawBoard];
    
}

-(IBAction)didTapRedrawBoard:(id)sender {
    
    [self drawBoard];
}


#pragma mark -
#pragma mark Panning methods

-(void)addPanningPieceToBoardWithPieceNumber:(NSUInteger)tag {
    
    // Get shape
    Piece *pieceToAdd = [self.piecesArray objectAtIndex:(tag - 1)];
    
    self.panningView = [pieceToAdd vendMovingViewForCellSize:self.pieceSize];
    
    self.pieceBeingMoved = pieceToAdd;

    [self.view addSubview:self.panningView];

}

-(void)movePanningPieceToFingerLocation:(CGPoint)fingerLocation {

    [self.xCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.x]];
    [self.yCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.y]];

    [self.panningView setFrame:CGRectMake(fingerLocation.x,
                                          fingerLocation.y,
                                          self.panningView.frame.size.width, self.panningView.frame.size.height)];

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

                             [self.panningView setFrame:CGRectMake(100, 100,
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
                             
                             [self.panningView setFrame:CGRectMake(100, 100,
                                                                   self.panningView.frame.size.width,
                                                                   self.panningView.frame.size.height)];
                             
                         } completion:^(BOOL finished) {
                             
                             [self.panningView removeFromSuperview];
                             self.panningView = nil;
                             
                         }];
        
        return;
    }

    [self.panningView removeFromSuperview];
    self.panningView = nil;

    [self.xCoord setText:@"-"];
    [self.yCoord setText:@"-"];
    
    // Add the piece to the board array
    // Convert finger location to piece origin
    int droppedRow = [self calculateRowNumberForConstrainedDropPoint:constrainedDropPoint];
    int droppedCol = [self calculateColNumberForConstrainedDropPoint:constrainedDropPoint];
    NSUInteger numberOfAffectedRows = self.pieceBeingMoved.rows;
    NSUInteger numberOfAffectedCols = self.pieceBeingMoved.columns;
    
    // Get the affected rows
    // Create holding tank for affected rows
    NSMutableArray *affectedRows = [[NSMutableArray alloc] init];
    
    // Grab the affected rows
    for (int row = droppedRow; row < (droppedRow + numberOfAffectedRows); row++) {
        [affectedRows addObject:[self.boardArray objectAtIndex:row]];
    }
    
    NSArray *shapeArray = self.pieceBeingMoved.shapeArray;
    
    // Iterate across each affected row
    for (int rowNumber = 0; rowNumber < [affectedRows count]; rowNumber++) {
        
        NSMutableArray *rowBeingUpdated = [affectedRows objectAtIndex:rowNumber];
        NSArray *shapeRow = [shapeArray objectAtIndex:rowNumber];
        
        // For each column in the affected row, update it
        for (int columnCount = 0; columnCount < numberOfAffectedCols; columnCount++) {
            
            // Get the corresponding element from the shape array
            NSNumber *shapeCell = [shapeRow objectAtIndex:columnCount];
            
            // Update the changed element if there's something there
            if (![shapeCell isEqualToNumber:@0]) {
                [rowBeingUpdated replaceObjectAtIndex:(columnCount + droppedCol) withObject:shapeCell];
            }
            
        }
        
    }
    
    // Add dropped piece to the piecesOnBoard array
    [self.piecesOnBoardArray addObject:self.pieceBeingMoved];
    
    self.pieceBeingMoved = nil;
    
    [self drawBoard];
    
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
    
    // Calculate size of shape
    float totalPieceWidth = self.pieceBeingMoved.columns * self.cellSize.width;
    float totalPieceHeight = self.pieceBeingMoved.rows * self.cellSize.height;
    
    
    // Check if dropped piece extends beyond board boundaries
    float rightEdgeOfPiece = constrainedDropPoint.x + totalPieceWidth;
    
    if (rightEdgeOfPiece > (self.boardView.frame.size.width)) {
        return YES;
    }
    
    // Calculate bottom edge of peice and adjust for status bar offset
    float bottomEdgeOfPiece = constrainedDropPoint.y + totalPieceHeight - kStatusBarOffsetValue;

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
    NSUInteger numberOfAffectedRows = self.pieceBeingMoved.rows;
    NSUInteger numberOfAffectedCols = self.pieceBeingMoved.columns;
    
    // By default, allow the placement here
    BOOL placementWillFail = NO;
    
    // Get the affected rows
    // Create holding tank for affected rows
    NSMutableArray *affectedRows = [[NSMutableArray alloc] init];
    
    // Grab the affected rows
    for (int row = droppedRow; row < (droppedRow + numberOfAffectedRows); row++) {
        [affectedRows addObject:[self.boardArray objectAtIndex:row]];
    }
    
    NSArray *shapeArray = self.pieceBeingMoved.shapeArray;
    
    // Iterate across each affected row
    for (int rowNumber = 0; rowNumber < [affectedRows count]; rowNumber++) {
        
        NSMutableArray *placementRow = [affectedRows objectAtIndex:rowNumber];
        NSArray *shapeRow = [shapeArray objectAtIndex:rowNumber];
        
        // For each column in the affected row, update it
        for (int columnCount = 0; columnCount < numberOfAffectedCols; columnCount++) {
            
            /*      shape cell = 0, placement cell = 0, placement OK
                    shape cell = 1, placement cell = 0, placement OK
                    shape cell = 1, placement cell = 1, placement NOK   */

            // Get the corresponding element from the shape array
            NSNumber *shapeCell = [shapeRow objectAtIndex:columnCount];
            NSNumber *placementCell = [placementRow objectAtIndex:(columnCount + droppedCol)];
            
            if ([shapeCell isEqualToNumber:@0]) {
                
                // Shape cell is empty
                placementWillFail = NO;
                
            } else {
                
                // Shape cell is full
                if (![placementCell isEqualToNumber:@0]) {
                    // Placement cell is full, therefore we have to fail
                    return YES;
                }
                
            }
            
        }
        
    }

    return placementWillFail;
}

-(int)calculateRowNumberForConstrainedDropPoint:(CGPoint)constrainedDropPoint {
    
    float yPosition = constrainedDropPoint.y;
    return (yPosition / self.cellSize.height);
    
}

-(int)calculateColNumberForConstrainedDropPoint:(CGPoint)constrainedDropPoint {
    float xPosition = constrainedDropPoint.x;
    return (xPosition / self.cellSize.width);
}

@end
