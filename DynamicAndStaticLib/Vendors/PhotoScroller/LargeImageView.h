//
//  LargeImageView.h
//  buildingqm
//
//  Created by Li ChangMing on 16/4/19.
//  Copyright © 2016年 SmartInspection.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LargeImageView;

@protocol LargeImageViewDelegate <NSObject>

- (void)largetImageViewDidUpdateContentImageView:(LargeImageView *)largeImageView;

@end

@interface LargeImageView : UIView
@property (nonatomic, weak) id<LargeImageViewDelegate> delegate;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) CGFloat zoomScale;
@property (nonatomic, readonly) UIView *contentImageView;
@property (nonatomic, strong) NSString *imagePath;

@end
