/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by HackFighter, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 * 
 * WARNING: This is generated code. Modify at your own risk and without support.
 */
#import "TiBase.h"

#ifdef USE_TI_MAP

#import <MapKit/MapKit.h>
#import "TiMapView.h"

@interface TiMapImageAnnotationView : MKAnnotationView<TiMapAnnotation> {
@private
	
	NSString * lastHitName;
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier map:(TiMapView*)map image:(UIImage*)image;
-(NSString *)lastHitName;

@end

#endif
