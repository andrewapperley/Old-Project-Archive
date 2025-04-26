//
//  ContinuePopUpList.m
//  LegendOfTheShadowRealm
//
//  Created by Andrew Apperley on 2013-03-10.
//
//

#import "ContinuePopUpList.h"
#import <QuartzCore/QuartzCore.h>
#import "Database.h"
#import "BaseLabel.h"
@implementation ContinuePopUpList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(void)initUI
{
    self.dialogStage = [[BaseView alloc] initWithFrame:CGRectMake(0, 0, 306, 200)];
    [self insertSubview:self.dialogStage aboveSubview:(BaseView *)self.blocker];
    self.dialogStage.layer.borderWidth = 10.0;
    self.dialogStage.layer.borderColor = [UIColor colorWithRed:93.0f/255.0f green:13.0f/255.0f blue:13.0f/255.0f alpha:1.0f].CGColor;
    self.dialogStage.layer.cornerRadius = 5.0f;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.dialogStage._width - 20, self.dialogStage._height - 20) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor blackColor];
    table.dataSource = self;
    table.delegate = self;
    /////
    table.separatorColor = [UIColor blackColor];
    /////
    [self.dialogStage addSubview:table];
    
    [super initUI];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *stats = [playerDatabase basicPlayerInformationByIndex:indexPath.row];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] autorelease];
        }
    ////////
    BaseLabel *information = [[BaseLabel alloc] initWithFrame:CGRectMake(0, 0, table.frame.size.width/2, 60)];
    information.numberOfLines = 0;
    information.text = [NSString stringWithFormat:@"%@\n%@",[stats objectForKey:@"level"],[stats objectForKey:@"currentMap"]];
    information.textAlignment = UITextAlignmentRight;
    information.backgroundColor = [UIColor clearColor];
    ////////
    
    cell.accessoryView = information;
    
    cell.textLabel.text = [stats objectForKey:@"name"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    UIView *selected = [[UIView alloc] initWithFrame:cell.frame];
    view.backgroundColor = [UIColor colorWithRed:79.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
    if(indexPath.row % 2)
        view.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:53.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
    cell.backgroundView = view;
    selected.backgroundColor = [UIColor colorWithRed:93.0f/255.0f green:13.0f/255.0f blue:13.0f/255.0f alpha:1.0f];
    cell.selectedBackgroundView = selected;
    
    [self destroy:view];
    [self destroy:information];
    [self destroy:selected];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [playerDatabase setCurrentRowId:indexPath.row];
    [[Shell shell] continueGame];
    [self closeDialog:UP];
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [playerDatabase numberOfPlayers];
}
-(int)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)dealloc
{
    [self destroy:table];
    
    [super dealloc];
}

@end