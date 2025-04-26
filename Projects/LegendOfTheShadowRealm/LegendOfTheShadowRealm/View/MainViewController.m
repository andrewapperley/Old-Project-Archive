//
//  MainViewController.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2012-11-17.
//
//

#import "MainViewController.h"
#import "MainGUI.h"
#import "MasterSkin.h"
#import "Shell.h"

@implementation MainViewController
@synthesize shell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    [self startLoadSequence];
    [super viewDidLoad];
}

- (void)startLoadSequence
{
    shell = [[Shell new] autorelease];
    [shell startUpSequence];
    [self.view addSubview:shell];
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIDeviceOrientationLandscapeLeft ||  interfaceOrientation ==  UIDeviceOrientationLandscapeRight)
    {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [shell destroy];
    [super dealloc];
}

@end
