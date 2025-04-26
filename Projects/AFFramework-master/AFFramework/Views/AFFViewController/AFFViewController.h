//
//  AFFViewController.h
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-04-13.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFEventCenter.h"

@class AFFView;

@interface AFFViewController : UIViewController
{
    @protected
    NSMutableArray *views;
}

@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic, readonly) BOOL isOpening;
@property (nonatomic, readonly) BOOL isClosed;
@property (nonatomic, readonly) BOOL isClosing;

+ (id)controller;

- (void)open:(AFFView *)lview;
- (void)open:(AFFView *)lview from:(CGPoint)openPoint to:(CGPoint)toPoint;
- (void)open:(AFFView *)lview from:(CGPoint)openPoint to:(CGPoint)toPoint andCloseCurrentViewTo:(CGPoint)closePoint;

- (void)close;
- (void)closeTo:(CGPoint)closePoint;

- (AFFView *)currentView;

AFFEventCreate(AFFEventInstance, evtOpening);
AFFEventCreate(AFFEventInstance, evtOpened);

AFFEventCreate(AFFEventInstance, evtClosing);
AFFEventCreate(AFFEventInstance, evtClosed);

@end
