//
//  AFFString.m
//  AFFramework
//
//  Created by Jeremy Fuellert on 2013-02-20.
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

#import "AFFString.h"

@implementation AFFString

+ (NSString *)trimString:(NSString *)string toIndexString:(NSString *)rangeString
{
    NSUInteger trimLocation = [string rangeOfString:rangeString].location;
    
    if(trimLocation != NAN && trimLocation < 2147483647)
    {
        string = [string substringToIndex:trimLocation];
    }
    
    return string;
}

@end
