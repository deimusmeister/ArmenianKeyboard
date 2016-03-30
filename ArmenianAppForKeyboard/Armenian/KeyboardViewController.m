//
//  KeyboardViewController.m
//  Armenian
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Alpha.h"

// Height sizes for iPhone modes
#define kiPhonePortraitHeight       286; //251 + 35;
#define kiPhoneLandscapeHeight      247; //212 + 35;

// Height sizes for iPad modes
#define kiPadPortraitHeight       224;
#define kiPadLandscapeHeight      206;


@interface KeyboardViewController ()

// Height constraint
@property (nonatomic) NSLayoutConstraint *heightConstraint;

// Helper variables
@property (nonatomic) BOOL isLandscape;

// Variables for storing keyboard height on landscape and portrait modes
@property (nonatomic) CGFloat portraitHeight;
@property (nonatomic) CGFloat landscapeHeight;

@end

@implementation KeyboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Perform custom initialization work here
        self.portraitHeight = kiPhonePortraitHeight;
        self.landscapeHeight = kiPhoneLandscapeHeight;
    }
    return self;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
    if (self.view.frame.size.width == 0 || self.view.frame.size.height == 0)
        return;
    
    // If height constraint is not initialized do not continue
    if (self.heightConstraint == nil)
        return;
    
    [self.view removeConstraint:self.heightConstraint];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenH = screenSize.height;
    CGFloat screenW = screenSize.width;
    BOOL isLandscape =  !(self.view.frame.size.width ==
                          (screenW*(screenW<screenH))+(screenH*(screenW>screenH)));
    NSLog(isLandscape ? @"Screen: Landscape" : @"Screen: Potriaint");
    self.isLandscape = isLandscape;
    if (isLandscape) {
        NSLog(@"%f", self.landscapeHeight);
        self.heightConstraint.constant = self.landscapeHeight;
        [self.view addConstraint:self.heightConstraint];
    } else {
        NSLog(@"%f", self.portraitHeight);
        self.heightConstraint.constant = self.portraitHeight;
        [self.view addConstraint:self.heightConstraint];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add alpha keyboard
    [self addAlphaKeyboard];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0.0
                                                          constant:self.portraitHeight];
    self.heightConstraint.priority = UILayoutPriorityRequired - 1; // This will eliminate the constraint conflict warning.
    [self.view addConstraint: self.heightConstraint];
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
                                                                                       multiplier:1.0 constant:60.0];
    
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
