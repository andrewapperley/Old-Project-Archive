//
//  AFFPDFUtil.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-04-08.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//
// This is a utility to easily make PDF documents and save them into the Documents folder of your app.
// It lets you create a PDF from either:
// - An array of UIImages with a split (how many images per page) and padding between each image, default 0 if you use function without padding
// - A single UIImage object
// - A single UIView object
// It also gives you access to deleting a single PDF document when passed a string (the file name) and any images that were used to create it if they
// were from the file system.
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

#import "AFFPDFUtil.h"
#import "ARCHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation AFFPDFUtil

+ (void)createPDFFileFromImageSet:(NSArray *)limageSet imagesPerPage:(int)split andName:(NSString *)lfileName
{
    [AFFPDFUtil createPDFFileFromImageSet:limageSet imagesPerPage:split andName:lfileName andPadding:0];
}

+ (void)createPDFFileFromImageSet:(NSArray *)limageSet imagesPerPage:(int)split andName:(NSString *)lfileName andPadding:(float)padding
{
    NSArray *imageSet = [[NSArray alloc] initWithArray:limageSet];
    NSString *fileName = [[NSString alloc] initWithString:lfileName];
    NSMutableData *data = [NSMutableData data];
    
    BOOL creating = TRUE;
    
    UIGraphicsBeginPDFContextToData(data, CGRectZero, nil);
    
    int a = 0;
    
    do {
        
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, [[imageSet objectAtIndex:a]size].width, [[imageSet objectAtIndex:a]size].height + [[imageSet objectAtIndex:MIN(a+1, [imageSet count]-1)]size].height + padding), nil);
        
        
        [((UIImage *)[imageSet objectAtIndex:a]) drawAtPoint:CGPointMake(0, 0)];
        a++;
        if(a >= [imageSet count])
            break;
        
        if(a >= [imageSet count])
            creating = FALSE;
    } while (creating);
    
    UIGraphicsEndPDFContext();
    
    NSArray* docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* _docDir = [docDir objectAtIndex:0];
    NSString* _docDirFileN = [_docDir stringByAppendingPathComponent:fileName];
    
    [data writeToFile:_docDirFileN atomically:YES];
    
    [imageSet ah_release];
    [fileName ah_release];
    
}

+ (void)createPDFFileFromView:(UIView *)lview andName:(NSString *)lfileName
{
    NSString *fileName = [[NSString alloc] initWithString:lfileName];
    NSMutableData *data = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(data, CGRectZero, nil);
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, lview.frame.size.width, lview.frame.size.height), nil);
    
    [[lview layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIGraphicsEndPDFContext();
    
    NSArray* docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* _docDir = [docDir objectAtIndex:0];
    NSString* _docDirFileN = [_docDir stringByAppendingPathComponent:fileName];
    
    [data writeToFile:_docDirFileN atomically:YES];
    
    [fileName ah_release];
    fileName = nil;
}

+ (void)createPDFFileFromImage:(UIImage *)limage andName:(NSString *)lfileName
{
    UIImage *image = [limage ah_retain];
    NSString *fileName = [[NSString alloc] initWithString:lfileName];
    NSMutableData *data = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(data, CGRectZero, nil);
    
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, image.size.width, image.size.height), nil);
    
    [limage drawAtPoint:CGPointMake(0, 0)];
    
    UIGraphicsEndPDFContext();
    
    NSArray* docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* _docDir = [docDir objectAtIndex:0];
    NSString* _docDirFileN = [_docDir stringByAppendingPathComponent:fileName];
    
    [data writeToFile:_docDirFileN atomically:YES];
    
    [fileName ah_release];
    fileName = nil;
    
    [image ah_release];
    image = nil;
    
}

+ (void)deletePDFByFileName:(NSString *)fileName andImages:(NSArray *)images
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    
    //Delete images
    if(images && images.count > 0)
    {
        for(uint i = 0; i < images.count; i++)
        {
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:(NSString *)[images objectAtIndex:i]];
            
            if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
    
    //Delete PDF file
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

@end
