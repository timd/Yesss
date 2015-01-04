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

@property (nonatomic) NSUInteger width;
@property (nonatomic) NSUInteger height;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGPoint origin;
@property (nonatomic, strong) NSArray *shapeArray;
@property (nonatomic) BOOL onBoard;

-(instancetype)initWithWidth:(NSUInteger)width andHeight:(NSUInteger)height andColor:(UIColor *)color andShape:(NSArray *)shape;

@end
