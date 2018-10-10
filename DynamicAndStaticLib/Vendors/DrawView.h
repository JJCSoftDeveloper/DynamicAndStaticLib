//
//  DrawView.h
//  DrawView
//
//  Created by Frank Michael on 4/8/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DrawingModeDefault, // Plain drawing view.
    SignatureMode       // Drawing view with a x and line for signatures.
} DrawingMode;

@class PathInfo, DrawView;

@interface PathInfo : NSObject
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) UIColor *color;
@end

@protocol DrawViewDelegate <NSObject>
@optional
- (void)drawView:(DrawView *)dv didDrawPathWithInfo:(PathInfo *)info;

@end

@interface DrawView : UIView

@property (nonatomic, weak) id<DrawViewDelegate> delegate;

// has draw path
@property (nonatomic, assign) BOOL hasDraw;

// Stroke Color
@property (nonatomic) UIColor *strokeColor;
// Stroke width
@property (nonatomic) CGFloat strokeWidth;
// If the drawing view can be drawn on. By default canEdit is true.
@property (nonatomic) BOOL canEdit;
// Debug value to add a box around the path when drawing a existing path.
@property (nonatomic) BOOL debugBox;
// Current mode for the drawing view. See DrawingMode enum for options.
@property (nonatomic) DrawingMode mode;
// Refresh the current drawing mode.
- (void)refreshCurrentMode;
// Draw a CGPath that already exists. canEdit is set to false if this is called.
- (void)drawPath:(CGPathRef)path;
// Draw a UIBezierPath that already exists. canEdit is set to false if this is called.
- (void)drawBezier:(UIBezierPath *)path;
// Animate the current path.
- (void)animatePath;
// Clear current drawing view.
- (void)clearDrawing;
// Undo last drawing
- (void)undoDrawing;
- (void)undoDrawingWithPathInfo:(PathInfo *)info;

- (void)rotatePaths:(double)degrees;

// Current UIBezierPath
- (UIBezierPath *)bezierPathRepresentation;
// Current UIImage of drawing view
- (UIImage *)imageRepresentation;

// All PathInfos
- (NSArray<PathInfo*> *)pathInfos;
@end
