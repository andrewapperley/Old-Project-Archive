#import "ApplicationMods.h"

@implementation ApplicationMods

+ (NSArray*) compiledMods
{
	NSMutableArray *modules = [NSMutableArray array];
	[modules addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"twitterbook",@"name",@"es.appio.twitterbook",@"moduleid",@"1.0",@"version",@"0795939b-df67-4f6f-9719-a4ec7767d904",@"guid",@"",@"licensekey",nil]];
	return modules;
}

@end
