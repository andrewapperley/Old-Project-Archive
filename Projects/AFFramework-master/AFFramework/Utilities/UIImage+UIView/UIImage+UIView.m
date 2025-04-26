//
//  UIImage+UIView.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-07-20.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "UIImage+UIView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (UIImage_UIView)

- (UIImage *)resizeImage:(UIImage *)limage toSize:(CGSize)size
{
    UIImage *currentImage = limage;
    UIGraphicsBeginImageContext(size);
    
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = size.width;
    thumbnailRect.size.height = size.height;
    
    [currentImage drawInRect:thumbnailRect];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(resizedImage == nil)
        NSLog(@"\nWARNING : Could not scale image.");
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}


+ (UIImage *)imageFromView:(UIView *)view
{
    //Create image from view
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    if(image == nil)
        NSLog(@"\nWARNING : Could not create image.");
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageFromView:(UIView *)view andRect:(CGRect)frame
{
    //Create image from view
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    if(image == nil)
        NSLog(@"\nWARNING : Could not create image.");
    
    UIGraphicsEndImageContext();
    
    //Clip image
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, frame);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
