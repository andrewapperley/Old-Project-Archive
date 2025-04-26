//
//  SpriteSheetManager.m
//  GLTesting
//
//  Created by Andrew Apperley on 2013-07-21.
//  Copyright (c) 2013 Andrew Apperley. All rights reserved.
//

#import "SpriteSheetManager.h"

@implementation SpriteSheetManager

@synthesize activeSheets = _activeSheets, textureCache = _textureCache;

static SpriteSheetManager *_spriteSheetManager;
+ (SpriteSheetManager *)spriteSheetManager
{
    return _spriteSheetManager;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _activeSheets = [NSMutableDictionary new];
        _textureCache = [NSMutableDictionary new];
    }
    return self;
}

- (void)loadTextureSheet:(NSString *)lsheetName
{
    //check if texture sheet is already in memory, if so return
    for (NSEnumerator *key in _activeSheets)
        if([key.description isEqualToString:lsheetName])
            return;
    
    
    //get path to plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:lsheetName ofType:@"plist"];
    
    //add texture sheet and plist to active sheets
    [_activeSheets setObject:[NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageWithContentsOfFile:lsheetName], @"sheet", [NSDictionary dictionaryWithContentsOfFile:path], @"plist", nil] forKey:lsheetName];
}

- (void)removeTextureSheetByName:(NSString *)lname
{
    //removes the sheet with that name
    [_activeSheets removeObjectForKey:lname];
    
    //creates a temp nsarray for holding the textures that need to be destroyed
    NSMutableArray *destroyArray = [NSMutableArray array];
    
    //gets all the keys for textures that used this sheet
    for (NSEnumerator *key in _textureCache.keyEnumerator) {
        
        //check each texture in memory to see if it equals the one being deleted
        if(![[key.description substringToIndex:NSMaxRange([key.description rangeOfString:lname])] isEqualToString:@""] && [[key.description substringFromIndex:key.description.length - 1] isEqualToString:[lname.description substringFromIndex:lname.description.length - 1]])
        {
            //add it to the destroy array
            [destroyArray addObject:key];
        }
    }
    
    //removes all the textures that used that sheet
    for (NSEnumerator *object in destroyArray) {
        [_textureCache removeObjectForKey:object.description];
    }
}

- (UIImage *)loadImageWithName:(NSString *)lname fromTextureSheet:(NSString *)lsheetName
{
   GLKVector2 imageCords = GLKVector2Make([[[_activeSheets objectForKey:lsheetName] objectForKey:@"_x"] floatValue], [[[_activeSheets objectForKey:lsheetName] objectForKey:@"_y"] floatValue]);
    if(![_textureCache objectForKey:[NSString stringWithFormat:@"%f_%f_%@",imageCords.x,imageCords.y,lsheetName]])
    {
        
        
    } else
        return [_textureCache objectForKey:[NSString stringWithFormat:@"%f_%f_%@",imageCords.x,imageCords.y,lsheetName]];
    
//    [_textureCache setObject:[NSString string] forKey:[self createHashFromImageIndex:lcords andSheetName:lsheetName]];
    
    NSLog(@"Error : Loading texture failed");
    return nil;
}


- (NSString *)createHashFromImageIndex:(GLKVector2)lcords andSheetName:(NSString *)lsheetName
{
    return [NSString stringWithFormat:@"%f_%f_%@",lcords.x,lcords.y,lsheetName];
}

- (void)dealloc
{
    [_activeSheets release];
    _activeSheets = nil;
    
    [_textureCache release];
    _textureCache = nil;
    
    [super dealloc];
}

@end