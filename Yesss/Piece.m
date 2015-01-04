//
//  Piece.m
//  Yesss
//
//  Created by Tim on 02/01/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

#import "Piece.h"

@implementation Piece

-(instancetype)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height andColor:(UIColor *)color andShape:(NSArray *)shape {

    if (self = [super init]) {
        
        self.width = width;
        self.height = height;
        self.color = color;
        self.shapeArray = shape;
        
    }
    
    return self;
    
}

@end
