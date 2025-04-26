//
//  BaseXMLParser.h
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-02-07.
//
//

#import "BaseObject.h"

@interface BaseXMLParser : BaseObject<NSXMLParserDelegate>
{
    NSString *_elementName;//A single string is used for now but an array could be passed in if needed in the future.
    NSString *_attribute;//Attribute to search for in the element name.
}
@property (nonatomic, retain)NSMutableArray *parsedObjects;
-(id)initWithElementName:(NSString *)e andAttribute:(NSString *)a;
-(void)loadXMLFile:(NSString *)p;
@end
