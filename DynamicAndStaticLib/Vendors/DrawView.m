//
//  DrawView.m
//  DrawView
//
//  Created by Frank Michael on 4/8/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

#import "DrawView.h"

@implementation PathInfo
@end

@interface DrawView ()
@property(nonatomic, strong)  NSMutableArray<PathInfo *> *paths;
@property(nonatomic, strong)  PathInfo *pathInfo;
@property(nonatomic, strong) CAShapeLayer *animateLayer;
@property(nonatomic, assign) BOOL isAnimating;
@property(nonatomic, assign) BOOL isDrawingExisting;
@property(nonatomic, strong) UIBezierPath *signLine;

//@property (nonatomic, assign) BOOL hasDraw;
@end

@implementation DrawView

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self setupUI];
  }
  return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self){
    [self setupUI];
  }
  return self;
}
#pragma mark - UI Configuration
- (void)setupUI{
  // Array of all the paths the user will draw.
  self.paths = [NSMutableArray new];
  // Default colors for drawing.
  self.backgroundColor = [UIColor clearColor];
  self.strokeColor = [UIColor blackColor];
  self.canEdit = YES;
  self.hasDraw = NO;
}

#pragma mark - View Drawing
- (void)drawRect:(CGRect)rect{
  // Drawing code
  if (!self.isAnimating){
    if (!self.isDrawingExisting){
      // Need to merge all the paths into a single path.
      for (PathInfo *pathInfo in self.paths){
        [pathInfo.color setStroke];
        [pathInfo.bezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
      }
    }else{
      [self.pathInfo.color setStroke];
      [self.pathInfo.bezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
  }
  
  if (_mode == SignatureMode){
    [[UIColor lightGrayColor] setStroke];
    [self.signLine strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
  }
}
- (void)drawPath:(CGPathRef)path{
  self.isDrawingExisting = YES;
  self.canEdit = NO;
  path = (__bridge CGPathRef)([PathInfo new]);
  UIBezierPath *bezierPath = [UIBezierPath new];
  bezierPath.CGPath = path;
  bezierPath.lineCapStyle = kCGLineCapRound;
  bezierPath.lineWidth = _strokeWidth;
  bezierPath.miterLimit = 0.0f;
  // If iPad apply the scale first so the paths bounds is in its final state.
  if ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound){
    [bezierPath setLineWidth:_strokeWidth];
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(2, 2);
    [bezierPath applyTransform:scaleTransform];
  }
  // Center the drawing within the view.
  CGRect charBounds = bezierPath.bounds;
  CGFloat charX = CGRectGetMidX(charBounds);
  CGFloat charY = CGRectGetMidY(charBounds);
  CGRect cellBounds = self.bounds;
  CGFloat centerX = CGRectGetMidX(cellBounds);
  CGFloat centerY = CGRectGetMidY(cellBounds);
  
  [bezierPath applyTransform:CGAffineTransformMakeTranslation(centerX-charX, centerY-charY)];
  
  [self setNeedsDisplay];
  
  // Debugging bounds view.
  if (_debugBox){
    UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(bezierPath.bounds.origin.x, bezierPath.bounds.origin.y, bezierPath.bounds.size.width, bezierPath.bounds.size.height)];
    [blockView setBackgroundColor:[UIColor blackColor]];
    [blockView setAlpha:0.5];
    [self addSubview:blockView];
  }
}
- (void)drawBezier:(UIBezierPath *)path{
  [self drawPath:path.CGPath];
}

- (void)undoDrawing {
  [self.paths removeLastObject];
  [self setNeedsDisplay];
}

- (void)undoDrawingWithPathInfo:(PathInfo *)info {
  [self.paths removeObject:info];
  [self setNeedsDisplay];
}

- (void)rotatePaths:(double)degrees {
  CGRect box = self.bounds;
  CGFloat radians = degrees / 180 * M_PI;
  CGRect bounds = self.bounds;
  CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
  CGAffineTransform transform = CGAffineTransformIdentity;
  transform = CGAffineTransformTranslate(transform, center.x, center.y);
  transform = CGAffineTransformRotate(transform, radians);
  transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
  [self.paths enumerateObjectsUsingBlock:^(PathInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj.bezierPath applyTransform:transform];
  }];
  [self setNeedsDisplay];
}

- (void)setMode:(DrawingMode)mode{
  _mode = mode;
  if (mode == DrawingModeDefault){
    self.signLine = nil;
  }else if (mode == SignatureMode){
    self.signLine = [UIBezierPath new];
    self.signLine.lineCapStyle = kCGLineCapRound;
    self.signLine.lineWidth = 3.0f;
    // Draw the X for the line
    [self.signLine moveToPoint:CGPointMake(20, self.frame.size.height-30)];
    [self.signLine addLineToPoint:CGPointMake(30, self.frame.size.height-40)];
    [self.signLine moveToPoint:CGPointMake(30, self.frame.size.height-30)];
    [self.signLine addLineToPoint:CGPointMake(20, self.frame.size.height-40)];
    // Draw the line for signing on
    [self.signLine moveToPoint:CGPointMake(20, self.frame.size.height-20)];
    [self.signLine addLineToPoint:CGPointMake(self.frame.size.width-20, self.frame.size.height-20)];
  }
  [self setNeedsDisplay];
}
- (void)refreshCurrentMode{
  [self setMode:self.mode];
}
- (void)clearDrawing{
  self.pathInfo = nil;
  self.paths = nil;
  self.signLine = nil;
  self.hasDraw = NO;
  [self setNeedsDisplay];
  [self setupUI];
}
#pragma mark - View Draw Reading
- (UIImage *)imageRepresentation{
  UIGraphicsBeginImageContext(self.bounds.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  [self.layer renderInContext:context];
  UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return viewImage;
}
- (UIBezierPath *)bezierPathRepresentation{
  UIBezierPath *singleBezPath = [UIBezierPath new];
  if (self.paths.count > 0){
    for (PathInfo *path in self.paths){
      [singleBezPath appendPath:path.bezierPath];
    }
  }else{
    singleBezPath = self.pathInfo.bezierPath;
  }
  return singleBezPath;
}

- (NSArray<PathInfo*> *)pathInfos {
  return [NSArray arrayWithArray:self.paths];
}
#pragma mark - Animation
- (void)animatePath{
  UIBezierPath *animatingPath = [UIBezierPath new];
  if (_canEdit){
    for (PathInfo *path in self.paths){
      [animatingPath appendPath:path.bezierPath];
    }
  }else{
    animatingPath = self.pathInfo.bezierPath;
  }
  // Clear out the existing view.
  self.isAnimating = YES;
  [self setNeedsDisplay];
  // Create shape layer that stores the path.
  self.animateLayer = [[CAShapeLayer alloc] init];
  self.animateLayer.fillColor = nil;
  self.animateLayer.path = animatingPath.CGPath;
  self.animateLayer.strokeColor = [_strokeColor CGColor];
  self.animateLayer.lineWidth = _strokeWidth;
  self.animateLayer.miterLimit = 0.0f;
  self.animateLayer.lineCap = @"round";
  // Create animation of path of the stroke end.
  CABasicAnimation *animation = [[CABasicAnimation alloc] init];
  animation.duration = 3.0;
  animation.fromValue = @(0.0f);
  animation.toValue = @(1.0f);
  animation.delegate = self;
  [self.animateLayer addAnimation:animation forKey:@"strokeEnd"];
  [self.layer addSublayer:self.animateLayer];
}
#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
  self.isAnimating = NO;
  [self.animateLayer removeFromSuperlayer];
  self.animateLayer = nil;
  [self setNeedsDisplay];
}
#pragma mark - Touch Detecting
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  if (_canEdit){
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath setLineCapStyle:kCGLineCapRound];
    [bezierPath setLineWidth:_strokeWidth];
    [bezierPath setMiterLimit:0];
    
    UITouch *currentTouch = [[touches allObjects] objectAtIndex:0];
    CGPoint point = [currentTouch locationInView:self];
    [bezierPath moveToPoint:point];
    
    self.pathInfo = [PathInfo new];
    self.pathInfo.bezierPath = bezierPath;
    self.pathInfo.color = _strokeColor;
    [self.paths addObject:self.pathInfo];
    self.hasDraw = YES;
  }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
  if (_canEdit){
    UITouch *movedTouch = [[touches allObjects] objectAtIndex:0];
    [self.pathInfo.bezierPath addLineToPoint:[movedTouch locationInView:self]];
    [self setNeedsDisplay];
  }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (_canEdit){
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    [self.pathInfo.bezierPath addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(drawView:didDrawPathWithInfo:)]) {
      [self.delegate drawView:self didDrawPathWithInfo:self.pathInfo];
    }
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  if (_canEdit){
    UITouch *touch = [[touches allObjects] objectAtIndex:0];
    [self.pathInfo.bezierPath addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(drawView:didDrawPathWithInfo:)]) {
      [self.delegate drawView:self didDrawPathWithInfo:self.pathInfo];
    }
  }
}


@end
