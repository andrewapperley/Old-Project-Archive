//
//  BaseXMLParser.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-02-07.
//
//

#import "BaseXMLParser.h"

@implementation BaseXMLParser

@synthesize parsedObjects;

-(id)initWithElementName:(NSString *)e andAttribute:(NSString *)a
{
    self = [super init];
    if(self)
    {
        _elementName = [[NSString stringWithString:e] retain];
        _attribute = [[NSString stringWithString:a] retain];
        parsedObjects = [NSMutableArray new];
        
    }
    
    return self;
}

-(void)loadXMLFile:(NSString *)p
{
    NSURL *url = [NSURL fileURLWithPath:p];
    
    NSXMLParser *addressParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    if (addressParser)
    {
        [addressParser setDelegate:self];
        [addressParser setShouldResolveExternalEntities:YES];
        [addressParser parse];
        
        [addressParser setDelegate:nil];
        [self destroy:addressParser];
        
        return;
    }

}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:_elementName])
    {
        [parsedObjects addObject:[attributeDict objectForKey:_attribute]];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //future uses maybe
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    //not needed right now
}

-(void)dealloc
{
    [self destroy:parsedObjects];
    [self destroy:_elementName];
    [self destroy:_attribute];
    [super dealloc];
}
@end
