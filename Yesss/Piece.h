//
//  Piece.h
//  Yesss
//
//  Created by Tim on 02/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Piece : NSObject

@property (nonatomic) NSUInteger columns;
@property (nonatomic) NSUInteger rows;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGPoint origin;
@property (nonatomic, strong) NSArray *shapeArray;
@property (nonatomic) BOOL onBoard;

-(instancetype)initWithColumns:(NSUInteger)columns andRows:(NSUInteger)rows andColor:(UIColor *)color andShape:(NSArray *)shape;
-(UIView *)vendMovingViewForCellSize:(CGSize)cellSize;
-(UIView *)vendBoardViewForCellSize:(CGSize)cellSize;

@end
