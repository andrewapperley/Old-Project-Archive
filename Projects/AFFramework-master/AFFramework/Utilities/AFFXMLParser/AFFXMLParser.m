//
//  AFFXMLParser.m
//  AFFramework
//
//  Created by Andrew Apperley on 2013-02-07.
//
//
// Init the XMLParser with a file path string to your xml file that is in the bundle.
// It will then create an exact representation of the xml file. Where single elements are saved as Dictionaries and multiple elements
// are saved as arrays of dictionaries. Use the 'parsedObjects' dictionary at the end of parsing, either by copying it out and deallocating the
// parser or using it directly.
//
//
//
//  This is a basic selector queueing class for non-automated queues.
//  The delegate class uses it's own selectors that are added or removed to the queue.
//  Upon running the queue from the delegate class the next selector in line is run then removed.
//  The 'runQueue' method must be included to the delegate class to manually run the next selector in queue.
//  The queue array / dictionary itself is created / destroyed based on objects in the queue.
//
//  It is the delegate class's responsibility to ensure selectors are being handled correctly;
//  the queue simply calls the methods provided with or without argument(s).
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

#import "AFFXMLParser.h"
#import "ARCHelper.h"

@implementation AFFXMLParser

@synthesize parsedObjects;

-(id)initWithFileName:(NSString *)file
{
    self = [super init];
    if(self)
    {
         _objectStack = [NSMutableArray new];
        [_objectStack addObject:[NSMutableDictionary dictionary]];
        [self loadXMLFile:file];
       
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
        [addressParser ah_release];
        addressParser = nil;
        
        return;
    }

}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSMutableDictionary *parent = [_objectStack lastObject];
    NSMutableDictionary *child = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
    
    if([parent objectForKey:elementName] != nil){
    
        if([[parent objectForKey:elementName] isKindOfClass:[NSMutableArray class]])
            //element exists but is an array
            [[parent objectForKey:elementName] addObject:child];
        else {
            //Element exists but is a dictionary
            NSMutableArray *childArray = [NSMutableArray array];
            [childArray addObject:[parent objectForKey:elementName]];
            [childArray addObject:child];
            [parent setObject:childArray forKey:elementName];
        }
    
    } else {
        [parent setObject:child forKey:elementName];
    }
    
    [_objectStack addObject:child];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    [_objectStack removeLastObject];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    parsedObjects = [[NSDictionary dictionaryWithDictionary:[_objectStack objectAtIndex:0]] retain];
    [_objectStack ah_release];
    _objectStack = nil;
}

-(void)dealloc
{
    [parsedObjects ah_release];
    parsedObjects = nil;
    
    [super ah_dealloc];
}
@end
