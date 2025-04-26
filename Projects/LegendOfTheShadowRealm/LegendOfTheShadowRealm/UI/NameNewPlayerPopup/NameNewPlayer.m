//
//  NameNewPlayer.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-12.
//
//

#import "NameNewPlayer.h"
#import "BaseTextField.h"
#import "TextConstants.h"
#import "BaseButton.h"
#import "Shell.h"
#import "Database.h"
@implementation NameNewPlayer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(void)initUI
{
    self.dialogStage = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    self.dialogStage.backgroundColor = RGB(38, 38, 38);
        
    nameField = [[BaseTextField alloc] initWithFrame:CGRectMake((self.dialogStage._width - (self.dialogStage._width - 20))/2, (self.dialogStage._height - 20)/2, self.dialogStage._width - 20, 20)];
    nameField.keyboardAppearance = UIKeyboardAppearanceAlert;
    nameField.keyboardType = UIKeyboardTypeNamePhonePad;
    nameField.backgroundColor = [UIColor colorWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    nameField.textColor = RGB(211, 211, 211);
    nameField.delegate = self;
    nameField.text = TEXT_CONSTANT_DIALOG_TITLE;
    
    
    BaseButton *button = [[BaseButton alloc] initWithImageBackground:[UIImage imageNamed:ASSET_VISUAL_CONTINUE_BUTTON] andPoint:CGPointMake((self.dialogStage._width - [UIImage imageNamed:ASSET_VISUAL_CONTINUE_BUTTON].size.width)/2, self.dialogStage._y + self.dialogStage._height - ([UIImage imageNamed:ASSET_VISUAL_CONTINUE_BUTTON].size.height + 3))withDelay:YES];

    [self addListener:EVENT_BUTTON_CLICKED andSel:@selector(onContinue) andSender:button];

    
    [self addSubview:self.dialogStage];
    [self.dialogStage addSubview:nameField];
    [self.dialogStage addSubview:button];
    
    [button destroy];
    
    [super initUI];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:TEXT_CONSTANT_DIALOG_TITLE])
        textField.text = @"";
    [UIView animateWithDuration:0.3 animations:^{
    
        self.dialogStage._y -= self.dialogStage._height/1.5;
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""])
        textField.text = TEXT_CONSTANT_DIALOG_TITLE;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.dialogStage._y += self.dialogStage._height/1.5;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        
    [textField resignFirstResponder];
    return YES;
}

-(void)onContinue
{
    if(![nameField.text isEqualToString:TEXT_CONSTANT_DIALOG_TITLE] && ![nameField.text isEqualToString:@""]){
        [[Shell shell] startNew:nameField.text];
        [self closeDialog:UP];
    }
}

-(void)dealloc
{
    [nameField destroy];
    
    [super dealloc];
}

@end