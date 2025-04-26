
//
//  DatabaseBase.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2012-11-24.
//
//

#import "BaseObject.h"
#import "DatabaseConstants.h"
#import <sqlite3.h>

@interface DatabaseBase : BaseObject

@property(nonatomic, readonly)NSString *databaseName;
@property(nonatomic, readonly)NSString *path;

- (id)initWithDatabase:(NSString*)ldatabase;
- (NSString *)databaseName;

//Database exceptions
+ (void)failedToOpen;
+ (void)failedToRunQuery:(const char *)query;

@end
