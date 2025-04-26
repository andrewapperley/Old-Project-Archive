//
//  ViewController.m
//  TestHarness
//
//  Created by Jeremy Fuellert on 2013-04-07.
//  Copyright (c) 2013 AFFramework. All rights reserved.
//

#import "ViewController.h"
#import "TestButton.h"
#import "AFFXMLParser.h"
#import "AFFVector.h"
#import "AFFViewController.h"
#import "TestView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self createSimpleTestButtons];
    [self createTestViewWithController];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createView
{
    view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self setView:view];
}

- (void)parseXML
{
    //testing out new xml parser
    AFFXMLParser *test = nil;
    test = [[AFFXMLParser alloc] initWithFileName:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"xml"]];
//    AFFLogObject([[[[[test.parsedObjects objectForKey:@"map"] objectForKey:@"layer"] objectForKey:@"data"]objectForKey:@"tile"] objectAtIndex:0]);
//    AFFLog();
    test = nil;
}

- (void)createSimpleTestButtons
{
    TestButton *testButton1 = [[TestButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testButton1.backgroundColor = [UIColor redColor];
    [[testButton1 evtInstanceClick] addHandler:AFFHandlerWithArgs(@selector(onMultiClick:andString:andNumber:andNumber:), @"String", [NSNumber numberWithInt:2], [NSNumber numberWithInt:3])];
    [[testButton1 evtInstanceClick] addHandler:AFFHandlerWithArgs(@selector(onMultiClick:andString:andNumber:andNumber:), @"String", [NSNumber numberWithInt:2], [NSNumber numberWithInt:3])];
    
    [view addSubview:testButton1];
    
    NSLog(@"Should return true : %d", [[testButton1 evtInstanceClick] hasHandler:AFFHandlerWithArgs(@selector(onMultiClick:andString:andNumber:andNumber:), @"String", [NSNumber numberWithInt:2], [NSNumber numberWithInt:3])]);
    
    NSLog(@"Should return false : %d", [[testButton1 evtInstanceClick] hasHandler:AFFHandler(@selector(onSingleClick))]);
        
    TestButton *testButton2 = [[TestButton alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    testButton2.backgroundColor = [UIColor blueColor];
//    [[[TestButton evtClassClick] addHandlerOneTime:AFFHandler(@selector(onSingleClick))] addHandler:AFFHandlerWithArgs(@selector(onMultiClick:andString:andNumber:andNumber:), @"String", [NSNumber numberWithInt:2], [NSNumber numberWithInt:3])];
    [[TestButton evtClassClick] addHandlerOneTime:AFFHandler(@selector(onSingleClick:))];
    
    [view addSubview:testButton2];    
}

- (void)onSingleClick
{
    NSLog(@"One time handler clicked with no params!");
}

- (void)onSingleClick:(AFFEvent *)event
{
    NSLog(@"One time handler clicked with param!");
}

- (void)onMultiClick:(AFFEvent *)event andString:(NSString *)string andNumber:(NSNumber *)lnumber andNumber:(NSNumber *)anumber
{
    NSLog(@"event.eventName : %@", event.eventName);
    NSLog(@"event.sender : %@", event.sender);
    NSLog(@"evet.data : %@", event.data);
    NSLog(@"argument1 : %@", string );
    NSLog(@"argument2 : %@", lnumber );
    NSLog(@"argument3 : %@", anumber );
}





- (void)createTestViewWithController
{

    
}



@end
