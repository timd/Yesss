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

@interface MainViewController ()
@property (nonatomic, weak) IBOutlet UIView *boardView;
@property (nonatomic, weak) IBOutlet UIView *templatePieceOne;
@property (nonatomic, weak) IBOutlet UIView *templatePieceTwo;
@property (nonatomic, weak) IBOutlet UIView *templatePieceThree;
@property (nonatomic, weak) IBOutlet UIView *templatePieceFour;
@property (nonatomic, weak) IBOutlet UIView *templatePieceFive;

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
            
            cellView.layer.borderColor = [UIColor blackColor].CGColor;
            cellView.layer.borderWidth = kCellBorderWidth;

            // Check if cell should be occupied
            int currentRowValue = [[rowArray objectAtIndex:col] intValue];
            
            if (currentRowValue != 0) {
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
    
    NSArray *row0 = nil;
    NSArray *row1 = nil;
    NSArray *row2 = nil;
    NSArray *row3 = nil;
    
    // Piece 1
    row0 = @[@1];
    Piece *pieceOne = [[Piece alloc] initWithColumns:1 andRows:1 andColor:[UIColor redColor] andShape:@[row0]];
    
    // Piece 2
    row0 = @[@1, @1];
    row1 = @[@0, @1];
    row2 = @[@1, @1];
    Piece *pieceTwo = [[Piece alloc] initWithColumns:2 andRows:3 andColor:[UIColor blueColor] andShape:@[row0, row1, row2]];

    // Piece 2
    row0 = @[@1];
    row1 = @[@1];
    row2 = @[@1];
    row3 = @[@1];
    Piece *pieceThree = [[Piece alloc] initWithColumns:1 andRows:4 andColor:[UIColor greenColor] andShape:@[row0, row1, row2, row3]];

    // Piece 2
    row0 = @[@1, @1, @1, @1];
    Piece *pieceFour = [[Piece alloc] initWithColumns:4 andRows:1 andColor:[UIColor yellowColor] andShape:@[row0]];

    // Piece 2
    row0 = @[@0, @1, @0];
    row1 = @[@1, @1, @1];
    row2 = @[@0, @1, @0];
    Piece *pieceFive = [[Piece alloc] initWithColumns:2 andRows:3 andColor:[UIColor brownColor] andShape:@[row0, row1, row2]];

    [self.piecesOnBoardArray addObjectsFromArray:@[pieceOne, pieceTwo, pieceThree, pieceFour, pieceFive]];
    
}

-(void)setupBoard {
    
    NSMutableArray *row0 = [@[@1,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row1 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row2 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row3 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row4 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row5 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row6 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row7 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row8 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    NSMutableArray *row9 = [@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0] mutableCopy];
    
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
        
        // Add moving piece to the board
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

    // Check if there is a piece at the tapped location
    if ([self checkForOccupiedDropLocation:constrainedDropPoint]) {
    
        // There is a piece, need to remove it
        NSMutableArray *rowArray = [self.boardArray objectAtIndex:droppedRow];

        [rowArray replaceObjectAtIndex:droppedCol withObject:@0];
        
        [self drawBoard];

    }
    
}

-(IBAction)didTapRedrawBoard:(id)sender {
    
    [self drawBoard];
}


#pragma mark -
#pragma mark Panning methods

-(void)addPanningPieceToBoardWithPieceNumber:(NSUInteger)tag {
    
    // Get shape
    Piece *pieceToAdd = [self.piecesOnBoardArray objectAtIndex:tag];
    
    self.panningView = [pieceToAdd vendMovingViewForCellSize:self.pieceSize];

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
    // Convert finger location to cell
    int droppedRow = [self calculateRowNumberForConstrainedDropPoint:constrainedDropPoint];
    int droppedCol = [self calculateColNumberForConstrainedDropPoint:constrainedDropPoint];
    
    // Get the current row value
    NSMutableArray *rowArray = [self.boardArray objectAtIndex:droppedRow];
    
    // Update the current row
    [rowArray replaceObjectAtIndex:droppedCol withObject:@1];
    
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
    NSMutableArray *rowArray = [self.boardArray objectAtIndex:droppedRow];
    
    int currentRowValue = [[rowArray objectAtIndex:droppedCol] intValue];

    if (currentRowValue != 0) {
        NSLog(@"The cell is occuplied");
        return YES;
    } else {
        NSLog(@"the cell is empty");
        return NO;
    }

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
