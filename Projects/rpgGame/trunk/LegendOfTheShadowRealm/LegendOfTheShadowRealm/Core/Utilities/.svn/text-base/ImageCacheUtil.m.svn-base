//
//  ImageCacheUtil.m
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-12.
//
//

#import "BaseImage.h"
#import "ImageCacheUtil.h"

#define IMAGE_TYPE_PNG      @"png"
#define DEFAULT_CACHE_SIZE  50

@implementation ImageCacheUtil

/*
 * Array
 */
+ (UIImage *)addImage:(NSString *)imageName toArray:(NSMutableArray *)images
{
    return [ImageCacheUtil addImage:imageName toArray:images andCapacity:DEFAULT_CACHE_SIZE];
}

+ (UIImage *)addImage:(NSString *)imageName toArray:(NSMutableArray *)images andCapacity:(uint)capacity
{
    //Empty set if full
    if(images.count >= capacity)
    {
        [images removeAllObjects];
    }
    
    //Pull the image from the array. Store new images into the set if needed.
    if(images && images.count > 0)
    {
        for(BaseImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                return image.image;
            }
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        BaseImage *newImage = [[[BaseImage alloc] initWithOrigin:CGPointZero andImage:newImageName] autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
        
    } else {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        BaseImage *newImage = [[[BaseImage alloc] initWithOrigin:CGPointZero andImage:newImageName] autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
    }
}

+ (void)removeImage:(NSString *)imageName fromArray:(NSMutableArray *)images
{
    if(images && images.count > 0)
    {
        for(BaseImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                [images removeObject:image];
            }
        }
    }
}

/*
 * Set
 */
+ (UIImage *)addImage:(NSString *)imageName toSet:(NSMutableSet *)images
{
    return [ImageCacheUtil addImage:imageName toSet:images andCapacity:DEFAULT_CACHE_SIZE];
}

+ (UIImage *)addImage:(NSString *)imageName toSet:(NSMutableSet *)images andCapacity:(uint)capacity
{
    //Empty set if full
    if(images.count >= capacity)
    {
        [images removeAllObjects];
    }
    
    //Pull the image from the set. Store new images into the set if needed.
    if(images && images.count > 0)
    {
        for(BaseImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                return image.image;
            }
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        BaseImage *newImage = [[[BaseImage alloc] initWithOrigin:CGPointZero andImage:newImageName] autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
        
    } else {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        BaseImage *newImage = [[[BaseImage alloc] initWithOrigin:CGPointZero andImage:newImageName] autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
    }
}

+ (void)removeImage:(NSString *)imageName toSet:(NSMutableSet *)images
{
    if(images && images.count > 0)
    {
        for(BaseImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                [images removeObject:image];
            }
        }
    }
}

@end
