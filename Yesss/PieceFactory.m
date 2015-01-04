//
//  ShapeFactory.m
//  Yesss
//
//  Created by Tim on 04/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import "PieceFactory.h"
#import "Piece.h"

@interface PieceFactory ()
@property (nonatomic, strong) UIColor *lightGreenColor;
@property (nonatomic, strong) UIColor *greyColor;
@property (nonatomic, strong) UIColor *purpleColor;
@property (nonatomic, strong) UIColor *whiteColor;
@property (nonatomic, strong) UIColor *redColor;
@property (nonatomic, strong) UIColor *yellowColor;
@property (nonatomic, strong) UIColor *darkGreenColor;
@property (nonatomic, strong) UIColor *lightPinkColor;
@property (nonatomic, strong) UIColor *darkPinkColor;
@property (nonatomic, strong) UIColor *lightBlueColor;
@property (nonatomic, strong) UIColor *darkBlueColor;
@property (nonatomic, strong) UIColor *orangeColor;

@end

@implementation PieceFactory

-(instancetype)init {
    if (self = [super init]) {
        self.lightGreenColor = [UIColor greenColor];
        self.greyColor = [UIColor greenColor];
        self.purpleColor = [UIColor greenColor];
        self.whiteColor = [UIColor greenColor];
        self.redColor = [UIColor greenColor];
        self.yellowColor = [UIColor greenColor];
        self.darkGreenColor = [UIColor greenColor];
        self.lightPinkColor = [UIColor greenColor];
        self.darkPinkColor = [UIColor greenColor];
        self.lightBlueColor = [UIColor greenColor];
        self.darkBlueColor = [UIColor greenColor];
        self.orangeColor = [UIColor greenColor];
    }
    
    return self;
}

// One dimensional pieces

-(Piece *)lightGreenPiece {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:2 andColor:self.lightGreenColor andShape:@[row0, row1]];
    [piece setShapeId:1];
    return piece;
}

-(Piece *)greyPiece {
    NSArray *row0 = @[@0, @1, @0];
    NSArray *row1 = @[@1, @1, @1];
    NSArray *row2 = @[@0, @1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.greyColor andShape:@[row0, row1, row2]];
    [piece setShapeId:2];
    return piece;
}

// two dimensional pieces

-(Piece *)purplePieceOne {
    NSArray *row0 = @[@1, @1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:1 andColor:self.purpleColor andShape:@[row0]];
    [piece setShapeId:3];
    return piece;
}

-(Piece *)purplePieceTwo {
    NSArray *row0 = @[@1];
    Piece *piece = [[Piece alloc] initWithColumns:1 andRows:4 andColor:self.purpleColor andShape:@[row0, row0, row0, row0]];
    [piece setShapeId:4];
    return piece;
}

// WHITE - 5, 6, 7, 8

-(Piece *)whitePieceOne {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:2 andColor:self.whiteColor andShape:@[row0, row1]];
    [piece setShapeId:5];
    return piece;
}

-(Piece *)whitePieceTwo {
    NSArray *row0 = @[@0, @1];
    NSArray *row1 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:2 andColor:self.whiteColor andShape:@[row0, row1]];
    [piece setShapeId:6];
    return piece;
}

-(Piece *)whitePieceThree {
    NSArray *row0 = @[@1, @0];
    NSArray *row1 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:2 andColor:self.whiteColor andShape:@[row0, row1]];
    [piece setShapeId:7];
    return piece;
}

-(Piece *)whitePieceFour {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:2 andColor:self.whiteColor andShape:@[row0, row1]];
    [piece setShapeId:8];
    return piece;
}

// RED - 9, 10, 11, 12

-(Piece *)redPieceOne {
    NSArray *row0 = @[@0, @1];
    NSArray *row1 = @[@1, @1];
    NSArray *row2 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.redColor andShape:@[row0, row1, row2]];
    [piece setShapeId:9];
    return piece;
}

-(Piece *)redPieceTwo {
    NSArray *row0 = @[@1, @1, @0];
    NSArray *row1 = @[@1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.redColor andShape:@[row0, row1]];
    [piece setShapeId:10];
    return piece;
}

-(Piece *)redPieceThree {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@1, @1];
    NSArray *row2 = @[@1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.redColor andShape:@[row0, row1, row2]];
    [piece setShapeId:11];
    return piece;
}

-(Piece *)redPieceFour {
    NSArray *row0 = @[@1, @1, @1];
    NSArray *row1 = @[@0, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.redColor andShape:@[row0, row1]];
    [piece setShapeId:12];
    return piece;
}

// YELLOW - 13, 14, 15, 16

-(Piece *)yelloPieceOne {
    NSArray *row0 = @[@1, @1, @1];
    NSArray *row1 = @[@1, @0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.yellowColor andShape:@[row0, row1]];
    [piece setShapeId:13];
    return piece;
}

-(Piece *)yelloPieceTwo {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@1, @0];
    NSArray *row2 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.yellowColor andShape:@[row0, row1, row2]];
    [piece setShapeId:14];
    return piece;
}

-(Piece *)yelloPieceThree {
    NSArray *row0 = @[@1, @0, @1];
    NSArray *row1 = @[@1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.yellowColor andShape:@[row0, row1]];
    [piece setShapeId:15];
    return piece;
}

-(Piece *)yelloPieceFour {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@0, @1];
    NSArray *row2 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.yellowColor andShape:@[row0, row1, row2]];
    [piece setShapeId:16];
    return piece;
}

// Dark green - 17, 19, 19, 20

-(Piece *)darkGreenPieceOne {
    NSArray *row0 = @[@1, @0];
    NSArray *row1 = @[@1, @0];
    NSArray *row2 = @[@1, @1];
    NSArray *row3 = @[@0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.darkGreenColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:17];
    return piece;
}

-(Piece *)darkGreenPieceTwo {
    NSArray *row0 = @[@0, @1, @1, @1];
    NSArray *row1 = @[@1, @1, @0, @0];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.darkGreenColor andShape:@[row0, row1]];
    [piece setShapeId:18];
    return piece;
}

-(Piece *)darkGreenPieceThree {
    NSArray *row0 = @[@1, @0];
    NSArray *row1 = @[@1, @1];
    NSArray *row2 = @[@0, @1];
    NSArray *row3 = @[@0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.darkGreenColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:19];
    return piece;
}

-(Piece *)darkGreenPieceFour {
    NSArray *row0 = @[@0, @0, @1, @1];
    NSArray *row1 = @[@1, @1, @1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.darkGreenColor andShape:@[row0, row1]];
    [piece setShapeId:20];
    return piece;
}

// LIGHT PINK - 21, 22, 23, 24

-(Piece *)lightPinkPieceOne {
    NSArray *row0 = @[@1, @0];
    NSArray *row1 = @[@1, @0];
    NSArray *row2 = @[@1, @1];
    NSArray *row3 = @[@1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.lightPinkColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:21];
    return piece;
}

-(Piece *)lightPinkPieceTwo {
    NSArray *row0 = @[@1, @1, @1, @1];
    NSArray *row1 = @[@0, @1, @0, @0];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.lightPinkColor andShape:@[row0, row1]];
    [piece setShapeId:22];
    return piece;
}

-(Piece *)lightPinkPieceThree {
    NSArray *row0 = @[@0, @1];
    NSArray *row1 = @[@1, @1];
    NSArray *row2 = @[@0, @1];
    NSArray *row3 = @[@0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.lightPinkColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:23];
    return piece;
}

-(Piece *)lightPinkPieceFour {
    NSArray *row0 = @[@0, @0, @1, @0];
    NSArray *row1 = @[@1, @1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.lightPinkColor andShape:@[row0, row1]];
    [piece setShapeId:24];
    return piece;
}

// DARK BLUE - 25, 26, 27, 28

-(Piece *)darkBluePieceOne {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@1, @0];
    NSArray *row2 = @[@1, @0];
    NSArray *row3 = @[@1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.darkBlueColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:25];
    return piece;
}

-(Piece *)darkBluePieceTwo {
    NSArray *row0 = @[@1, @1, @1, @1];
    NSArray *row1 = @[@0, @0, @0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.darkBlueColor andShape:@[row0, row1]];
    [piece setShapeId:26];
    return piece;
}

-(Piece *)darkBluePieceThree {
    NSArray *row0 = @[@0, @1];
    NSArray *row1 = @[@0, @1];
    NSArray *row2 = @[@0, @1];
    NSArray *row3 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:4 andColor:self.darkBlueColor andShape:@[row0, row1, row2, row3]];
    [piece setShapeId:27];
    return piece;
}

-(Piece *)darkBluePieceFour {
    NSArray *row0 = @[@1, @0, @0, @0];
    NSArray *row1 = @[@1, @1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:4 andRows:2 andColor:self.darkBlueColor andShape:@[row0, row1]];
    [piece setShapeId:28];
    return piece;
}

// LIGHT BLUE - 29, 30, 31, 32

-(Piece *)lightBluePieceOne {
    NSArray *row0 = @[@1, @0, @0];
    NSArray *row1 = @[@1, @0, @0];
    NSArray *row2 = @[@1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.lightBlueColor andShape:@[row0, row1, row2]];
    [piece setShapeId:29];
    return piece;
}

-(Piece *)lightBluePieceTwo {
    NSArray *row0 = @[@1, @1, @1];
    NSArray *row1 = @[@1, @0, @0];
    NSArray *row2 = @[@1, @0, @0];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.lightBlueColor andShape:@[row0, row1, row2]];
    [piece setShapeId:30];
    return piece;
}

-(Piece *)lightBluePieceThree {
    NSArray *row0 = @[@1, @1, @1];
    NSArray *row1 = @[@0, @0, @1];
    NSArray *row2 = @[@0, @0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.lightBlueColor andShape:@[row0, row1, row2]];
    [piece setShapeId:31];
    return piece;
}

-(Piece *)lightBluePieceFour {
    NSArray *row0 = @[@0, @0, @1];
    NSArray *row1 = @[@0, @0, @1];
    NSArray *row2 = @[@1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.lightBlueColor andShape:@[row0, row1, row2]];
    [piece setShapeId:32];
    return piece;
}

// ORANGE - 33, 34, 35, 36

-(Piece *)orangePieceOne {
    NSArray *row0 = @[@1, @0];
    NSArray *row1 = @[@1, @0];
    NSArray *row2 = @[@1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.orangeColor andShape:@[row0, row1, row2]];
    [piece setShapeId:33];
    return piece;
}

-(Piece *)orangePieceTwo {
    NSArray *row0 = @[@1, @1, @1];
    NSArray *row1 = @[@1, @0, @0];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.orangeColor andShape:@[row0, row1]];
    [piece setShapeId:34];
    return piece;
}

-(Piece *)orangePieceThree {
    NSArray *row0 = @[@1, @1];
    NSArray *row1 = @[@0, @1];
    NSArray *row2 = @[@0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:2 andRows:3 andColor:self.orangeColor andShape:@[row0, row1, row2]];
    [piece setShapeId:35];
    return piece;
}

-(Piece *)orangePieceFour {
    NSArray *row0 = @[@0, @0, @1];
    NSArray *row1 = @[@1, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:2 andColor:self.orangeColor andShape:@[row0, row1]];
    [piece setShapeId:36];
    return piece;
}

// DARK PINK - 37, 38, 39, 40

-(Piece *)darkPinkPieceOne {
    NSArray *row0 = @[@1, @1, @0];
    NSArray *row1 = @[@0, @1, @1];
    NSArray *row2 = @[@0, @0, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.darkPinkColor andShape:@[row0, row1, row2]];
    [piece setShapeId:37];
    return piece;
}

-(Piece *)darkPinkPieceTwo {
    NSArray *row0 = @[@0, @0, @1];
    NSArray *row1 = @[@0, @1, @1];
    NSArray *row2 = @[@1, @1, @0];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.darkPinkColor andShape:@[row0, row1, row2]];
    [piece setShapeId:38];
    return piece;
}

-(Piece *)darkPinkPieceThree {
    NSArray *row0 = @[@1, @0, @0];
    NSArray *row1 = @[@1, @1, @0];
    NSArray *row2 = @[@0, @1, @1];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.darkPinkColor andShape:@[row0, row1, row2]];
    [piece setShapeId:39];
    return piece;
}

-(Piece *)darkPinkPieceFour {
    NSArray *row0 = @[@0, @1, @1];
    NSArray *row1 = @[@1, @1, @0];
    NSArray *row2 = @[@1, @0, @0];
    Piece *piece = [[Piece alloc] initWithColumns:3 andRows:3 andColor:self.darkPinkColor andShape:@[row0, row1, row2]];
    [piece setShapeId:40];
    return piece;
}

-(NSArray *)setOfPieces {
    
    NSArray *returnArray = @[[self lightGreenPiece],
                             [self greyPiece],
                             [self purplePieceOne],
                             [self purplePieceTwo],
                             [self whitePieceOne],
                             [self whitePieceTwo],
                             [self whitePieceThree],
                             [self whitePieceFour],
                             [self redPieceOne],
                             [self redPieceTwo],
                             [self redPieceThree],
                             [self redPieceFour],
                             [self yelloPieceOne],
                             [self yelloPieceTwo],
                             [self yelloPieceThree],
                             [self yelloPieceFour],
                             [self darkGreenPieceOne],
                             [self darkGreenPieceTwo],
                             [self darkGreenPieceThree],
                             [self darkGreenPieceFour],
                             [self lightPinkPieceOne],
                             [self lightPinkPieceTwo],
                             [self lightPinkPieceThree],
                             [self lightPinkPieceFour],
                             [self darkBluePieceOne],
                             [self darkBluePieceTwo],
                             [self darkBluePieceThree],
                             [self darkBluePieceFour],
                             [self lightBluePieceOne],
                             [self lightBluePieceTwo],
                             [self lightBluePieceThree],
                             [self lightBluePieceFour],
                             [self orangePieceOne],
                             [self orangePieceTwo],
                             [self orangePieceThree],
                             [self orangePieceFour],
                             [self darkPinkPieceOne],
                             [self darkPinkPieceTwo],
                             [self darkPinkPieceThree],
                             [self darkPinkPieceFour]
                             ];

    return returnArray;
    
}


@end
