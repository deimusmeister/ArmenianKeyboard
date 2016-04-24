//
//  ViewController.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "ViewController.h"
#import "CYRKeyboardButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    textField.delegate = self;
    [self.view addSubview:textField];
    
//    [self.view addSubview:text];
    
    self.view.backgroundColor = [UIColor blueColor];
   
    UIView* empty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    //    empty.backgroundColor = [UIColor clearColor];
    //    empty.layer.borderColor = [UIColor redColor].CGColor;
    //    empty.layer.borderWidth = 2.f;
    [self.view addSubview:empty];
    
    
    UIView* p = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 400)];
        p.backgroundColor = [UIColor yellowColor];
    //    empty.layer.borderColor = [UIColor redColor].CGColor;
    //    empty.layer.borderWidth = 2.f;
    [empty addSubview:p];
    
    
    CYRKeyboardButton* button;
    button = [[CYRKeyboardButton alloc] initWithFrame:CGRectMake(100, 300, 30, 50)];
    button.delegate = self;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.input = @"A";
    [button setHitTestEdgeInsets:UIEdgeInsetsMake(-300.f, -100.f, -100.f, -100.f)];
    
    [empty addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cyrKeyboardButtonInputDelegateMethod: (NSString *)key
{
    NSLog(@"%@", key);
}

@end
