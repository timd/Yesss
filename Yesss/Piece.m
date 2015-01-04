//
//  Piece.m
//  Yesss
//
//  Created by Tim on 02/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import "Piece.h"
#import <QuartzCore/QuartzCore.h>

@implementation Piece

-(instancetype)initWithColumns:(NSUInteger)columns andRows:(NSUInteger)rows andColor:(UIColor *)color andShape:(NSArray *)shape {

    if (self = [super init]) {
        
        self.columns = columns;
        self.rows = rows;
        self.color = color;
        self.shapeArray = shape;
        
    }
    
    return self;
    
}

-(UIView *)vendViewForAdjustedCellSize:(CGSize)cellSize {
    
    // Build container view
    float viewWidth = self.columns * cellSize.width;
    float viewHeight = self.rows * cellSize.height;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];

    // Build interior views
    // Iterate across each row (max number of rows = self.height
    for (int row = 0; row < self.rows; row++) {
        
        // Get array for the row
        NSArray *rowArray = [self.shapeArray objectAtIndex:row];
        
        // Iterate across the columns
        for (int col = 0; col < [rowArray count]; col++) {
            
            // Mask to get value in this column
            NSNumber *cellValue = [rowArray objectAtIndex:col];
            
            if (![cellValue isEqualToNumber:@0]) {
            
                // Calculate X position of block
                float xPosition = col * cellSize.width;
                
                // Calculate yPositon of block
                float yPosition = row * cellSize.height;
                
                // Create block view
                UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(xPosition,
                                                                            yPosition,
                                                                            cellSize.width,
                                                                             cellSize.height)];
                
                // Colour block
                [blockView setBackgroundColor:self.color];
                [blockView.layer setBorderWidth:1.0f];
                blockView.layer.cornerRadius = (cellSize.width / 2);
                [blockView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
                
                // Add block view to container view
                
                [containerView addSubview:blockView];
                
            }
            
        }
        
    }
    
    return containerView;
    
}

-(UIView *)vendMovingViewForCellSize:(CGSize)cellSize {
    
    // Make the shape smaller to allow size for drop shadow
    CGSize adjustedSize = CGSizeMake(cellSize.width - 10, cellSize.height - 10);
    return [self vendViewForAdjustedCellSize:adjustedSize];

}

-(UIView *)vendBoardViewForCellSize:(CGSize)cellSize {
    // Vend full-sized shape
    return [self vendViewForAdjustedCellSize:cellSize];
}

-(UIView *)vendSidebarViewForCellSize:(CGSize)cellSize {
    // Vend full-sized shape
    CGSize newSize = CGSizeMake(cellSize.width / 2, cellSize.height / 2);
    return [self vendViewForAdjustedCellSize:newSize];
}


@end
