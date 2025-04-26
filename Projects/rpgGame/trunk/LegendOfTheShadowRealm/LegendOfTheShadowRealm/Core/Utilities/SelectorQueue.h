//
//  SelectorQueue.h
//  LegendOfTheShadowRealm
//
//  Created by Jeremy Fuellert on 2013-01-28.
//
//

#import "BaseObject.h"

@interface SelectorQueue : BaseObject
{
    @private
    id delegate;
    NSMutableArray *queue;
    NSMutableDictionary *selectorDictionary;
}

- (id)initWithDelegate:(id)ldelegate;

//Queue Methods
- (void)addSelectorToQueue:(SEL)selector;
- (void)addSelectorToQueue:(SEL)selector andArg:(id)arg;
- (void)addSelectorToQueue:(SEL)selector andArg:(id)arg1 andArg:(id)arg2;
- (void)removeSelectorFromQueue:(SEL)selector;
- (void)removeAllSelectorsFromQueue;

- (void)runQueue;

@end
