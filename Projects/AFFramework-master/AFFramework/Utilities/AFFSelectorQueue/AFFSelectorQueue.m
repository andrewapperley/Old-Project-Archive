//
//  AFFSelectorQueue.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-01-28.
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


#import "AFFSelectorQueue.h"
#import "ARCHelper.h"

#define ARG_1       @"_1"
#define ARG_2       @"_2"

@implementation AFFSelectorQueue

- (id)initWithDelegate:(id)ldelegate
{
    self = [super init];
    if(self)
    {
        delegate = [ldelegate ah_retain];
        queue = [NSMutableArray new];
        selectorDictionary = [NSMutableDictionary new];
    }
    return self;
}

/*
 * Selector Handling
 */
- (void)addSelectorToQueue:(SEL)selector
{
    [self addSelectorToQueue:selector andArg:nil andArg:nil];
}

- (void)addSelectorToQueue:(SEL)selector andArg:(id)arg
{
    [self addSelectorToQueue:selector andArg:arg andArg:nil];
}

- (void)addSelectorToQueue:(SEL)selector andArg:(id)arg1 andArg:(id)arg2
{
    [queue addObject:NSStringFromSelector(selector)];
    
    //Add dictionary objects
    if(arg1 && ![arg1 isEqual:[NSNull null]])
        [selectorDictionary setObject:arg1 forKey:[NSStringFromSelector(selector) stringByAppendingFormat:ARG_1]];
    
    if(arg2 && ![arg2 isEqual:[NSNull null]])
        [selectorDictionary setObject:arg2 forKey:[NSStringFromSelector(selector) stringByAppendingFormat:ARG_2]];
}

- (void)removeSelectorFromQueue:(SEL)selector
{
    if(queue && queue.count > 0)
    {
        for(uint i = 0; i < queue.count; i++)
        {
            if([(NSString *)[queue objectAtIndex:i] isEqualToString:NSStringFromSelector(selector)])
            {
                [queue removeObjectAtIndex:i];
                break;
            }
        }
    }
    
    //Clean up dictionary objects
    NSString *firstArg = [NSStringFromSelector(selector) stringByAppendingFormat:ARG_1];
    NSString *secondArg = [NSStringFromSelector(selector) stringByAppendingFormat:ARG_2];
    
    if(selectorDictionary && selectorDictionary.count > 0)
    {
        for(uint i = 0; i < selectorDictionary.count; i++)
        {
            if([selectorDictionary objectForKey:firstArg] && ![[selectorDictionary objectForKey:firstArg] isEqual:[NSNull null]])
            {
                [selectorDictionary removeObjectForKey:firstArg];
            }
            
            if([selectorDictionary objectForKey:secondArg] && ![[selectorDictionary objectForKey:secondArg] isEqual:[NSNull null]])
            {
                [selectorDictionary removeObjectForKey:secondArg];
            }
        }
    }
}

- (void)removeAllSelectorsFromQueue
{
    if(queue)
        [queue removeAllObjects];
    
    if(selectorDictionary)
        [selectorDictionary removeAllObjects];
}

/*
 * Queue Handling
 */
- (void)runQueue
{
    [self performNextSelectorInQueue];
}

- (void)performNextSelectorInQueue
{
    if(queue)
    {
        if(queue.count > 0)
        {            
            //Extract selector
            NSString *selectorString = (NSString *)[queue objectAtIndex:0];
            SEL selector = NSSelectorFromString(selectorString);
            
            //Extract argument(s) (if any)
            id arg1 = nil;
            id arg2 = nil;
            NSString *firstArg = [selectorString stringByAppendingFormat:ARG_1];
            NSString *secondArg = [selectorString stringByAppendingFormat:ARG_2];
            
            if(selectorDictionary && selectorDictionary.count > 0)
            {
                //First arg
                if([selectorDictionary objectForKey:firstArg] && ![[selectorDictionary objectForKey:firstArg] isEqual:[NSNull null]])
                {
                    arg1 = [[selectorDictionary objectForKey:firstArg] ah_retain];
                }
                
                //Second arg
                if([selectorDictionary objectForKey:secondArg] && ![[selectorDictionary objectForKey:secondArg] isEqual:[NSNull null]])
                {
                    arg2 = [[selectorDictionary objectForKey:secondArg] ah_retain];
                }
            }
            
            //Perform selector with two arguments
            if(arg1 && ![arg1 isEqual:[NSNull null]] && arg2 && ![arg2 isEqual:[NSNull null]])
            {
                [delegate performSelector:selector withObject:arg1 withObject:arg2];
                
                [selectorDictionary removeObjectForKey:firstArg];
                [selectorDictionary removeObjectForKey:secondArg];
                [arg1 ah_release];
                arg1 = nil;
                [arg2 ah_release];
                arg2 = nil;
                
            //Perform selector with a first argument
            } else if(arg1 && ![arg1 isEqual:[NSNull null]]) {
                [delegate performSelector:selector withObject:arg1];
                [selectorDictionary removeObjectForKey:firstArg];
                [arg1 ah_release];
                arg1 = nil;;
                
            //Perform selector with a second argument
            } else if(arg2 && ![arg2 isEqual:[NSNull null]]) {
                [delegate performSelector:selector withObject:arg2];
                [selectorDictionary removeObjectForKey:secondArg];
                [arg2 ah_release];
                arg2 = nil;
                
            //Perform selector with no arguments
            } else {
                [delegate performSelector:selector];
            }
                        
            [queue removeObjectAtIndex:0];
        } else {
            [self removeAllSelectorsFromQueue];
        }
    }
}

- (void)dealloc
{
    [delegate ah_release];
    delegate = nil;
    [queue ah_release];
    queue = nil;
    [selectorDictionary ah_release];
    selectorDictionary = nil;
    [super ah_dealloc];
}

@end
