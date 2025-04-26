//
//  ImageCacheUtil.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-03-12.
//
//

#import "BaseObject.h"

@interface ImageCacheUtil : BaseObject

+ (UIImage *)addImage:(NSString *)imageName toArray:(NSMutableArray *)images;
+ (UIImage *)addImage:(NSString *)imageName toArray:(NSMutableArray *)images andCapacity:(uint)capacity;
+ (void)removeImage:(NSString *)imageName fromArray:(NSMutableArray *)images;

+ (UIImage *)addImage:(NSString *)imageName toSet:(NSMutableSet *)images;
+ (UIImage *)addImage:(NSString *)imageName toSet:(NSMutableSet *)images andCapacity:(uint)capacity;;
+ (void)removeImage:(NSString *)imageName toSet:(NSMutableSet *)images;

@end
