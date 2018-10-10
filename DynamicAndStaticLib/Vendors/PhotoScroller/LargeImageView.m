//
//  LargeImageView.m
//  buildingqm
//
//  Created by Li ChangMing on 16/4/19.
//  Copyright © 2016年 SmartInspection.cn. All rights reserved.
//

#import "LargeImageView.h"
#import "PhotoScrollerCommon.h"
#import "TiledImageBuilder.h"
#import "ImageScrollView.h"
@import ImageIO;
@import CoreGraphics;
@import MobileCoreServices;


@interface LargeImageView() <ImageScrollViewDelegate>
@property (nonatomic, strong, readonly) UIActivityIndicatorView *loadingView;
@property (nonatomic, strong, readonly) ImageScrollView *imageScrollView;
@property (nonatomic, strong, readonly) dispatch_queue_t queue;
@property (nonatomic, strong) TiledImageBuilder *imageBuilder;
@property (nonatomic, assign) CGFloat zoomScale;

@end

@implementation LargeImageView

- (instancetype)init {
  if (self = [super init]) {
    _queue = dispatch_queue_create("cn.SmartInspection.buildingqm.LargeImageView", DISPATCH_QUEUE_SERIAL);
    [self setupSubviews];
  }
  return self;
}

- (UIScrollView *)scrollView {
  return self.imageScrollView;
}

- (UIView *)contentImageView {
  return self.imageScrollView.imageView;
}

- (void)setupSubviews {
  _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  _imageScrollView = [[ImageScrollView alloc] initWithFrame:self.bounds];
  
  [self addSubview:self.imageScrollView];
  [self addSubview:self.loadingView];
  
  self.loadingView.color = [UIColor ext_appTintColor];
  self.imageScrollView.imageScrollViewDelegate = self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.imageScrollView.frame = self.bounds;
  self.loadingView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

- (void)updateImage {
  [self.imageScrollView.imageView removeFromSuperview];
  self.imageScrollView.imageView = nil;
  self.imageBuilder = nil;
  [self.loadingView stopAnimating];
  if (_imagePath) {
    [self.loadingView startAnimating];
    NSString *path = [_imagePath copy];
    
    CGSize size = self.bounds.size;
    dispatch_async(self.queue, ^{
      // Create thumbnail placehodler
//      CFDictionaryRef optionsRef = (__bridge CFDictionaryRef)
//      @{(id)kCGImageSourceShouldCache : @NO,
//        (id)kCGImageSourceShouldCacheImmediately : @NO,
////        (id)kCGImageSourceCreateThumbnailFromImageAlways: @YES,
//        (id)kCGImageSourceThumbnailMaxPixelSize: @(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))),
//        };
//      CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:path], optionsRef);
//      CGImageRef thumbnailImageRef = CGImageSourceCreateThumbnailAtIndex(imageSourceRef, 0, optionsRef);
//      UIImage *thumbnailImage = [UIImage imageWithCGImage:thumbnailImageRef];
//      CGImageRelease(thumbnailImageRef);
//      CFRelease(imageSourceRef);
//      dispatch_async(dispatch_get_main_queue(), ^{
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:thumbnailImage];
//        [self.imageScrollView displayObject:imageView];
//        self.imageScrollView.maximumZoomScale = 5;
//      });
      
      //
      TiledImageBuilder *imageBuilder = [[TiledImageBuilder alloc] initWithImagePath:path
                                                                          withDecode:cgimageDecoder
                                                                                size:size
                                                                         orientation:0];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.imagePath isEqualToString:path]) {
          self.imageBuilder = imageBuilder;
          [self.imageScrollView displayObject:self.imageBuilder];
          [self.loadingView stopAnimating];
          [self.delegate largetImageViewDidUpdateContentImageView:self];
        }
      });
    });
  }
}

#pragma mark -
- (void)setImagePath:(NSString *)imagePath {
  if (_imagePath != imagePath) {
    _imagePath = imagePath;
    [self updateImage];
  }
}

#pragma mark -
- (void)imageScrollView:(ImageScrollView *)imageScrollView didZoom:(CGFloat)scale {
  self.zoomScale = scale;
}

@end
