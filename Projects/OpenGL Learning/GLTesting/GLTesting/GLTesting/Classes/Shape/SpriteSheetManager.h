//
//  SpriteSheetManager.h
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-21.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface SpriteSheetManager : NSObject

+ (SpriteSheetManager *)spriteSheetManager;

- (void)loadTextureSheet:(NSString *)lsheetName;
- (UIImage *)loadImageWithName:(NSString *)lname fromTextureSheet:(NSString *)lsheetName;

@property(nonatomic, retain, readonly) NSMutableDictionary *activeSheets;
@property(nonatomic, retain, readonly) NSMutableDictionary *textureCache;
@end