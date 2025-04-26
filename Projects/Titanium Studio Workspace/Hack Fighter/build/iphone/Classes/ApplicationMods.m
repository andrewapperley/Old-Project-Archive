#import "ApplicationMods.h"

@implementation ApplicationMods

+ (NSArray*) compiledMods
{
	NSMutableArray *modules = [NSMutableArray array];
	[modules addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"box2d",@"name",@"ti.box2d",@"moduleid",@"0.9",@"version",@"A391B0DB-94F5-4820-9972-F7D7843545A6",@"guid",@"",@"licensekey",nil]];
	return modules;
}

@end
