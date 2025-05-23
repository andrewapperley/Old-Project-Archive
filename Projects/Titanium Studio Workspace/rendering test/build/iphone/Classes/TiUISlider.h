/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2012 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#ifdef USE_TI_UISLIDER

#import "TiUIView.h"


@interface TiUISlider : TiUIView<LayoutAutosizing> {
@private
	UISlider *sliderView;
	NSDate* lastTouchUp;
	NSTimeInterval lastTimeInterval;
	
	UIControlState thumbImageState;
	UIControlState rightTrackImageState;
	UIControlState leftTrackImageState;
    TiDimension leftTrackLeftCap;
    TiDimension leftTrackTopCap;
    TiDimension rightTrackLeftCap;
    TiDimension rightTrackTopCap;
}

- (IBAction)sliderChanged:(id)sender;

@end

#endif