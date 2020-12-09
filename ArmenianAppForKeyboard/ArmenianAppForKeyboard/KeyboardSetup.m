//
//  KeyboardSetup.m
//  ArmenianKeyboard
//
//  Created by Levon Poghosyan on 5/22/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "KeyboardSetup.h"
#import "ios_detect.h"

@implementation KeyboardSetup

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Background color
        self.backgroundColor = [UIColor whiteColor];
        
        // Add logo
        UIImageView* homeIcon = [[UIImageView alloc] init];
        homeIcon.image = [UIImage imageNamed:@"IconSettings.png"];
        
        
        CGFloat hoffsetX = (frame.size.width - [UIImage imageNamed:@"IconSettings.png"].size.width) / 2;
        CGFloat hoffsetY = 20;
        if (IS_IPHONE_X)
            hoffsetY += 20;
        
        homeIcon.frame = CGRectMake(hoffsetX, hoffsetY,
                                    [UIImage imageNamed:@"IconSettings.png"].size.width,
                                    [UIImage imageNamed:@"IconSettings.png"].size.height);
        [self addSubview:homeIcon];
        
        // Add label
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   homeIcon.frame.origin.y + homeIcon.frame.size.height + 10,
                                                                   frame.size.width, 50)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        UIColor* greenColor = [UIColor blackColor];
        UIColor* whiteColor = [UIColor grayColor];
        
        
        UIFont *font1 = [UIFont fontWithName:@"SFUIDisplay-Light" size:20];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObjectsAndKeys:font1,      NSFontAttributeName,
                                   greenColor,  NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Armenian Keyboard\n" attributes: arialDict];
        
        UIFont *font2 = [UIFont fontWithName:@"SFUIDisplay-Light" size:15];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObjectsAndKeys:font2,      NSFontAttributeName,
                                    whiteColor, NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Settings" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        label.attributedText = aAttrString1;
        
        [self addSubview:label];
        
        // Add table view
        CGFloat toffsetY = label.frame.origin.y + label.frame.size.height + 10;
        
        UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, toffsetY, frame.size.width, frame.size.height - toffsetY)];
        tableView.layoutMargins = UIEdgeInsetsZero;
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        tableView.bounces = NO;
        tableView.separatorColor = [UIColor colorWithRed:231.f/255.f green:231.f/255.f blue:231.f/255.f alpha:1.f];
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [self addSubview:tableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SettingTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
        
        if (indexPath.row == 0)
        {
            // Add Tailing Character option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Keyboard Sound";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];
            
            // Add Insert Tab switch
            UISwitch* ITSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [ITSwitch addTarget:self action: @selector(insertTab:) forControlEvents:UIControlEventValueChanged];
            ITSwitch.on = [userDefaults boolForKey:@"ArmKeyboardSound"];
            [cell.contentView addSubview:ITSwitch];
        }
        
        if (indexPath.row == 1)
        {
            // Add Tailing Character option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Input Prediction";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];
            
            // Add Insert Enter switch
            UISwitch* IESwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [IESwitch addTarget:self action: @selector(insertEnter:) forControlEvents:UIControlEventValueChanged];
            IESwitch.on = [userDefaults boolForKey:@"ArmKeyboardPrediction"];
            [cell.contentView addSubview:IESwitch];
        }
        
        if (indexPath.row == 2)
        {
            // Add Tailing Character option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Bold Text";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];
        
            // Add Backup Chargin switch
            UISwitch* BCSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [BCSwitch addTarget:self action: @selector(backupCharging:) forControlEvents:UIControlEventValueChanged];
            BCSwitch.on = [userDefaults boolForKey:@"ArmKeyboardBoldText"];
            [cell.contentView addSubview:BCSwitch];
        }
        
        if (indexPath.row == 3)
        {
            // Add Auto Capitalization option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Auto Capitalization";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];

            // Add Auto Capitalization switch
            UISwitch* BCSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [BCSwitch addTarget:self action: @selector(autoCapitalization:) forControlEvents:UIControlEventValueChanged];
            BCSwitch.on = [userDefaults boolForKey:@"ArmKeyboardAutoCapitalization"];
            [cell.contentView addSubview:BCSwitch];
        }
        
        if (indexPath.row == 4)
        {
            // Add Auto Capitalization option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Use \"ու\" instead of \"ւ\"";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];

            // Add Auto Capitalization switch
            UISwitch* BCSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [BCSwitch addTarget:self action: @selector(uLetterHandle:) forControlEvents:UIControlEventValueChanged];
            BCSwitch.on = [userDefaults boolForKey:@"ArmKeyboardULetter"];
            [cell.contentView addSubview:BCSwitch];
        }
        
        if (indexPath.row == 5)
        {
            // Add Auto Capitalization option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Hide \"՞\" from main layout";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];

            // Add Auto Capitalization switch
            UISwitch* BCSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [BCSwitch addTarget:self action: @selector(questionSignHandler:) forControlEvents:UIControlEventValueChanged];
            BCSwitch.on = [userDefaults boolForKey:@"ArmKeyboardQuestionSign"];
            [cell.contentView addSubview:BCSwitch];
        }
        
        if (indexPath.row == 6)
        {
            // Add Tailing Character option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width / 2, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"\"՞\" context characters";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];

        
            // Add Tailing Character option input field
            UITextField* TCField = [[UITextField alloc] initWithFrame:CGRectMake(self.frame.size.width - 126 - 11, 8,
                                                                                 126, 44)];
            TCField.text = [userDefaults stringForKey:@"ArmKeyboardQuestionSignContext"];
            TCField.delegate = self;
            TCField.autocorrectionType = UITextAutocorrectionTypeNo;
            TCField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            [TCField addTarget:self action:@selector(questionMarkCharacters:) forControlEvents:UIControlEventEditingChanged];
            TCField.borderStyle = UITextBorderStyleRoundedRect;
            TCField.backgroundColor = [UIColor colorWithRed:232.f/255.f green:232.f/255.f blue:232.f/255.f alpha:1.f];
            TCField.textAlignment = NSTextAlignmentCenter;
            TCField.textColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            [cell.contentView addSubview:TCField];
        }
        
        if (indexPath.row == 7)
        {
            // Add Auto Capitalization option label
            UILabel* TClabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 21, self.frame.size.width, 22)];
            TClabel.font = [UIFont fontWithName:@"OpenSans" size:18.f];
            TClabel.text = @"Auto Comma Insertion";
            TClabel.textColor = tableView.separatorColor = [UIColor colorWithRed:65.f/255.f green:65.f/255.f blue:65.f/255.f alpha:1.f];
            TClabel.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:TClabel];

            // Add Auto Capitalization switch
            UISwitch* BCSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.frame.size.width - 55 - 11, 14,
                                                                            126, 44)];
            [BCSwitch addTarget:self action: @selector(automaticCommaHandler:) forControlEvents:UIControlEventValueChanged];
            BCSwitch.on = [userDefaults boolForKey:@"ArmKeyboardCommaInsertion"];
            [cell.contentView addSubview:BCSwitch];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (void)insertTab:(id)sender
{
    UISwitch* ITSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:ITSwitch.on forKey:@"ArmKeyboardSound"];
    [userDefaults synchronize];
}

- (void)insertEnter:(id)sender
{
    UISwitch* IESwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:IESwitch.on forKey:@"ArmKeyboardPrediction"];
    [userDefaults synchronize];
}

- (void)backupCharging:(id)sender
{
    UISwitch* BCSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:BCSwitch.on forKey:@"ArmKeyboardBoldText"];
    [userDefaults synchronize];
}

- (void)autoCapitalization:(id)sender
{
    UISwitch* BCSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:BCSwitch.on forKey:@"ArmKeyboardAutoCapitalization"];
    [userDefaults synchronize];
}

- (void)uLetterHandle:(id)sender
{
    UISwitch* BCSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:BCSwitch.on forKey:@"ArmKeyboardULetter"];
    [userDefaults synchronize];
}

- (void)questionSignHandler:(id)sender
{
    UISwitch* BCSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:BCSwitch.on forKey:@"ArmKeyboardQuestionSign"];
    [userDefaults synchronize];
}

- (void)questionMarkCharacters:(id)sender
{
    UITextField* TCField = (UITextField*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    NSString* text = TCField.text;
    [userDefaults setObject:text forKey:@"ArmKeyboardQuestionSignContext"];
    [userDefaults synchronize];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger length = [textField.text length];
    if (length >= 4 && ![string isEqualToString:@""]) {
        textField.text = [textField.text substringToIndex:4];
        return NO;
    }
    return YES;
}

- (void)automaticCommaHandler:(id)sender
{
    UISwitch* BCSwitch  = (UISwitch*)sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:BCSwitch.on forKey:@"ArmKeyboardCommaInsertion"];
    [userDefaults synchronize];
}

@end
