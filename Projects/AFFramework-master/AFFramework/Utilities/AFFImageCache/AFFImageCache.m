//
//  AFFImageCache.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-03-12.
//
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "AFFImage.h"
#import "AFFImageCache.h"
#import "ARCHelper.h"

#define IMAGE_TYPE_PNG      @"png"
#define DEFAULT_CACHE_SIZE  50  //Number of images held in the cache array / set

@implementation AFFImageCache

/*
 * Array
 */
+ (UIImage *)addImage:(NSString *)imageName toArray:(NSMutableArray *)images
{
    return [AFFImageCache addImage:imageName toArray:images andCapacity:DEFAULT_CACHE_SIZE];
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
        for(AFFImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                return image.image;
            }
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        AFFImage *newImage = [[[AFFImage alloc] initWithOrigin:CGPointZero andImage:newImageName] ah_autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
        
    } else {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        AFFImage *newImage = [[[AFFImage alloc] initWithOrigin:CGPointZero andImage:newImageName] ah_autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
    }
}

+ (void)removeImage:(NSString *)imageName fromArray:(NSMutableArray *)images
{
    if(images && images.count > 0)
    {
        for(AFFImage *image in images)
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
    return [AFFImageCache addImage:imageName toSet:images andCapacity:DEFAULT_CACHE_SIZE];
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
        for(AFFImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                return image.image;
            }
        }
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        AFFImage *newImage = [[[AFFImage alloc] initWithOrigin:CGPointZero andImage:newImageName] ah_autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
        
    } else {
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:IMAGE_TYPE_PNG];
        UIImage *newImageName = [UIImage imageWithContentsOfFile:filePath];
        
        AFFImage *newImage = [[[AFFImage alloc] initWithOrigin:CGPointZero andImage:newImageName] ah_autorelease];
        [newImage setName:imageName];
        
        [images addObject:newImage];
        
        return newImage.image;
    }
}

+ (void)removeImage:(NSString *)imageName toSet:(NSMutableSet *)images
{
    if(images && images.count > 0)
    {
        for(AFFImage *image in images)
        {
            if([image.name isEqualToString:imageName])
            {
                [images removeObject:image];
            }
        }
    }
}

@end
