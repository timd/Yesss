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
@property (nonatomic, weak) IBOutlet UILabel *xCoord;
@property (nonatomic, weak) IBOutlet UILabel *yCoord;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self drawBoard];
    [self setupPieces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Board methods

-(void)drawBoard {
    
    NSUInteger boardHeight = self.view.frame.size.height;
    
    CGSize cellSize = CGSizeMake(boardHeight/10, boardHeight/10);
    
    // Draw rows
    for (int row = 0; row < 10; row++) {
        
        // Draw columns
        for (int col = 0; col < 10; col++) {

            CGFloat xPosition = col * cellSize.width;
            CGFloat yPosition = row * cellSize.height;
            
            UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(xPosition, yPosition, cellSize.width, cellSize.height)];
            
            cellView.layer.borderColor = [UIColor blackColor].CGColor;
            cellView.layer.borderWidth = 1.0f;

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

#pragma mark -
#pragma mark Interaction methods

-(IBAction)didPanPiece:(id)sender {
    
    UIPanGestureRecognizer *panRecognizer = (UIPanGestureRecognizer *)sender;
    
    // Add view
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        
        self.panningView = [[UIView alloc] initWithFrame:self.pieceView.frame];
        [self.panningView setBackgroundColor:[UIColor greenColor]];
        [self.view addSubview:self.panningView];
        
    }
    
    if (panRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint fingerLocation = [panRecognizer locationInView:self.view];
        
        NSLog(@"Finger = %@", NSStringFromCGPoint(fingerLocation));
        
        [self.xCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.x]];
        [self.yCoord setText:[NSString stringWithFormat:@"%0.0f", fingerLocation.y]];
        
        [self.panningView setFrame:CGRectMake(fingerLocation.x, fingerLocation.y, self.panningView.frame.size.width, self.panningView.frame.size.height)];
        
    }
    
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        
        // Drop piece on board
        UIView *droppedPiece = [[UIView alloc] initWithFrame:self.panningView.frame];
        [droppedPiece setBackgroundColor:self.panningView.backgroundColor];
        [self.view addSubview:droppedPiece];
        [self.piecesOnBoardArray addObject:droppedPiece];
        
        // Add gesture recognizer to piece
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapToRemovePieceFromBoard:)];
        [tapRecognizer setNumberOfTapsRequired:1];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [droppedPiece addGestureRecognizer:tapRecognizer];
        
        [self.panningView removeFromSuperview];
        self.panningView = nil;
        
        [self.xCoord setText:@"-"];
        [self.yCoord setText:@"-"];
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


@end
