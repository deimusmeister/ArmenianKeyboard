//
//  KeyboardViewController.m
//  Armenian
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Alpha.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add alpha keyboard
    [self addAlphaKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)textWillChange:(id<UITextInput>)textInput
{
}

- (void)textDidChange:(id<UITextInput>)textInput
{
//    // The app has just changed the document's contents, the document context has been updated.
//    
//    UIColor *textColor = nil;
//    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
//        textColor = [UIColor whiteColor];
//    } else {
//        textColor = [UIColor blackColor];
//    }
//    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (void) addAlphaKeyboard
{
    // Add alpha layout
    Alpha* alpha = [[Alpha alloc] init];
    
    // Register for numeric input
    alpha.delegate = self;
    
    // Set a unique tag
//    alpha.tag = kAlpha;
    [self.view addSubview:alpha];
    
    // Add size constraints
    alpha.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Left constraint
    NSLayoutConstraint *alphaKeyboardButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:alpha
                                                                                         attribute:NSLayoutAttributeLeft
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:self.view
                                                                                         attribute:NSLayoutAttributeLeft
                                                                                        multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonLeftConstraint];
    
    // Right constraint
    NSLayoutConstraint *alphaKeyboardButtonRightConstraint = [NSLayoutConstraint constraintWithItem:alpha
                                                                                          attribute:NSLayoutAttributeRight
                                                                                          relatedBy:NSLayoutRelationEqual
                                                                                             toItem:self.view
                                                                                          attribute:NSLayoutAttributeRight
                                                                                         multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonRightConstraint];
    
    // Bottom constraint
    NSLayoutConstraint *alphaKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:alpha
                                                                                           attribute:NSLayoutAttributeBottom
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:self.view
                                                                                           attribute:NSLayoutAttributeBottom
                                                                                          multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *alphaKeyboardButtonTopConstraint = [NSLayoutConstraint constraintWithItem:alpha
                                                                                        attribute:NSLayoutAttributeTop
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self.view
                                                                                        attribute:NSLayoutAttributeTop
                                                                                       multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonTopConstraint];
}

#pragma mark AlphaInputDelegate

- (void) alphaSpecialKeyInputDelegateMethod:(NSInteger)tag
{
    if (tag == kAlphaGlobeButton)
        [self advanceToNextInputMode];
}

- (void) alphaInputDelegateMethod: (NSString *) key
{
    // Insert typed text
    [self.textDocumentProxy insertText:key];
}

- (void) alhpaInputRemoveCharacter
{
    // Remove a character
    [self.textDocumentProxy deleteBackward];
}

@end
