//
//  CirclePad.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-12-02.
//
//

#import "BaseView.h"

@class BaseImage;

@interface CirclePad : BaseView
{
    @private
    NSTimer *timer;
    BaseImage *thumbImage;
    BOOL run;
}

@end
