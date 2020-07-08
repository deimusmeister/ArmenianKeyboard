//
//  KeyboardViewController.m
//  Armenian
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "KeyboardViewController.h"
#import "Alpha.h"
#import "PredictiveBar.h"
#import "Colors.h"
#import "ios_detect.h"

// Height sizes for iPhone modes
#define kiPhonePortraitHeight       286; //251 + 35;
#define kiPhoneLandscapeHeight      247; //212 + 35;

// Height sizes for iPad modes
#define kiPadPortraitHeight       348; //313 + 35;
#define kiPadLandscapeHeight      433; //398 + 35;

// Define the tags for the UI components
#define kAlpha      1234
#define kPredBar    4321

// Target definition
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


@interface KeyboardViewController ()

// Height constraint
@property (nonatomic) NSLayoutConstraint *heightConstraint;

// Helper variables
@property (nonatomic) BOOL isLandscape;
@property (nonatomic) BOOL isPredictionEnabled;
@property (nonatomic) BOOL isAutoCapitalizationEnabled;
@property (nonatomic) BOOL isULetterHidden;
@property (nonatomic) BOOL isQuestionHightHidden;

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
        if (IPAD)
        {
            self.portraitHeight = kiPadPortraitHeight;
            self.landscapeHeight = kiPadLandscapeHeight;
        }
        else
        {
            self.portraitHeight = kiPhonePortraitHeight;
            self.landscapeHeight = kiPhoneLandscapeHeight;
        }
        
        // Instantiate currently typed word container
        currentWord = [[NSString alloc] init];
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
    self.isLandscape = isLandscape;
    if (isLandscape) {
        self.heightConstraint.constant = self.landscapeHeight;
        [self.view addConstraint:self.heightConstraint];
    } else {
        self.heightConstraint.constant = self.portraitHeight;
        [self.view addConstraint:self.heightConstraint];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load prediction settings
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    if ([userDefaults objectForKey:@"ArmKeyboardPrediction"] == nil)
    {
        [userDefaults setBool:YES forKey:@"ArmKeyboardPrediction"];
    }
    self.isPredictionEnabled = [userDefaults boolForKey:@"ArmKeyboardPrediction"];
    
    // Minimize keyboard if the prediction is not enabled
    if (self.isPredictionEnabled == NO)
    {
        self.portraitHeight = self.portraitHeight - 35;
        self.landscapeHeight = self.landscapeHeight - 35;
    }
    
    // Load bold text
    if ([userDefaults objectForKey:@"ArmKeyboardBoldText"] == nil)
    {
        [userDefaults setBool:NO forKey:@"ArmKeyboardBoldText"];
    }
    ((Colors*)[Colors sharedManager]).isBoldEnabled = [userDefaults boolForKey:@"ArmKeyboardBoldText"];
    
    
    if ([userDefaults objectForKey:@"ArmKeyboardAutoCapitalization"] == nil)
    {
        [userDefaults setBool:YES forKey:@"ArmKeyboardAutoCapitalization"];
    }
    self.isAutoCapitalizationEnabled = [userDefaults boolForKey:@"ArmKeyboardAutoCapitalization"];
    
    if ([userDefaults objectForKey:@"ArmKeyboardULetter"] == nil)
    {
        [userDefaults setBool:NO forKey:@"ArmKeyboardULetter"];
    }
    self.isULetterHidden = [userDefaults boolForKey:@"ArmKeyboardULetter"];
    
    if ([userDefaults objectForKey:@"ArmKeyboardQuestionSign"] == nil)
    {
        [userDefaults setBool:NO forKey:@"ArmKeyboardQuestionSign"];
    }
    self.isQuestionHightHidden = [userDefaults boolForKey:@"ArmKeyboardQuestionSign"];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (SYSTEM_VERSION_LESS_THAN(@"11.2.6"))
    {
        // Setup the colors manager
        [[Colors sharedManager] setTextDocumentProxy:self.textDocumentProxy];

        // Add alpha keyboard
        [self addAlphaKeyboard];

        if (self.isPredictionEnabled == YES)
        {
            // Add prediction bar
            [self addPredictionBar];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.2.6"))
    {
        // Setup the colors manager
        [[Colors sharedManager] setTextDocumentProxy:self.textDocumentProxy];
        
        // Add alpha keyboard
        [self addAlphaKeyboard];
        
        if (self.isPredictionEnabled == YES)
        {
            // Add prediction bar
            [self addPredictionBar];
        }
    }
    
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0.0
                                                          constant:self.portraitHeight];
    self.heightConstraint.priority = UILayoutPriorityRequired - 1; // This will eliminate the constraint conflict warning.
    [self.view addConstraint: self.heightConstraint];
    
    // Load spellchecker dictionary
    [bar loadDictionary];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Release the resources
    [bar suspendSpeller];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)textWillChange:(id<UITextInput>)textInput
{
    // Setup the colors manager
    [[Colors sharedManager] setTextDocumentProxy:self.textDocumentProxy];
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    // Setup the colors manager
    [[Colors sharedManager] setTextDocumentProxy:self.textDocumentProxy];
}

- (void) addAlphaKeyboard
{
    // Add alpha layout
    Alpha* alpha = [[Alpha alloc] init];
    
    // Register for numeric input and settings
    alpha.delegate = self;
    alpha.isULetterHidden = self.isULetterHidden;
    
    // Set a unique tag
    alpha.tag = kAlpha;
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
    
    // Width constraint
    CGFloat factor = (self.isPredictionEnabled ? 0.83 : 1.0);
    NSLayoutConstraint *alphaKeyboardButtonTopConstraint = [NSLayoutConstraint constraintWithItem:alpha
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self.view
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                       multiplier:factor constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonTopConstraint];
    
    // Update the keyboard mode on startup
    if (self.isAutoCapitalizationEnabled &&
        (self.textDocumentProxy.autocapitalizationType == UITextAutocapitalizationTypeWords ||
         self.textDocumentProxy.autocapitalizationType == UITextAutocapitalizationTypeSentences ||
         self.textDocumentProxy.autocapitalizationType == UITextAutocapitalizationTypeAllCharacters) &&
        (self.textDocumentProxy.documentContextBeforeInput == nil ||
         [self.textDocumentProxy.documentContextBeforeInput isEqualToString:@"\n"] ||
         [self.textDocumentProxy.documentContextBeforeInput isEqualToString:@""]))
    {
        // Switch to shifted mode
        [alpha toShiftMode];
    }
}

- (void) addPredictionBar
{
    Alpha* view = nil;
    for (UIView *subUIView in self.view.subviews) {
        if ([subUIView isKindOfClass:[Alpha class]])
        {
            Alpha* tmp = (Alpha*)subUIView;
            // Check if we found the proper button
            BOOL properView = (tmp.tag == kAlpha);
            if (properView == YES)
            {
                view = tmp;
                break;
            }
        }
    }
    
    // Add prediction layout
    bar = [[PredictiveBar alloc] init];
    
    // Register input selection callback
    bar.delegate = self;
    
    // Set a unique tag
    bar.tag = kPredBar;
    [self.view addSubview:bar];
    
    // Add size constraints
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Left constraint
    NSLayoutConstraint *alphaKeyboardButtonLeftConstraint = [NSLayoutConstraint constraintWithItem:bar
                                                                                         attribute:NSLayoutAttributeLeft
                                                                                         relatedBy:NSLayoutRelationEqual
                                                                                            toItem:self.view
                                                                                         attribute:NSLayoutAttributeLeft
                                                                                        multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonLeftConstraint];
    
    // Right constraint
    NSLayoutConstraint *alphaKeyboardButtonRightConstraint = [NSLayoutConstraint constraintWithItem:bar
                                                                                          attribute:NSLayoutAttributeRight
                                                                                          relatedBy:NSLayoutRelationEqual
                                                                                             toItem:self.view
                                                                                          attribute:NSLayoutAttributeRight
                                                                                         multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonRightConstraint];
    
    // Bottom constraint
    NSLayoutConstraint *alphaKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                                           attribute:NSLayoutAttributeTop
                                                                                           relatedBy:NSLayoutRelationEqual
                                                                                              toItem:bar
                                                                                           attribute:NSLayoutAttributeBottom
                                                                                          multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *alphaKeyboardButtonTopConstraint = [NSLayoutConstraint constraintWithItem:bar
                                                                                        attribute:NSLayoutAttributeTop
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self.view
                                                                                        attribute:NSLayoutAttributeTop
                                                                                       multiplier:1.0 constant:0.0];
    
    [self.view addConstraint:alphaKeyboardButtonTopConstraint];
}

-(void)updatePredictionInput
{
    // Update prediction input
    NSRange a = [currentWord rangeOfString:@" " options:NSBackwardsSearch];
    NSRange b = [currentWord rangeOfString:@"\n" options:NSBackwardsSearch];
    
    // Last word
    NSString* word = @"";
    
    if (a.location != NSNotFound && b.location != NSNotFound)
    {
        if (a.location < b.location)
            word = [NSString stringWithString:[currentWord substringFromIndex:b.location + 1]];
        else
            word = [NSString stringWithString:[currentWord substringFromIndex:a.location + 1]];
    }
    else if (a.location != NSNotFound)
    {
        word = [NSString stringWithString:[currentWord substringFromIndex:a.location + 1]];
    }
    else if(b.location != NSNotFound)
    {
        word = [NSString stringWithString:[currentWord substringFromIndex:b.location + 1]];
    }
    else
        word = [NSString stringWithString:currentWord];
    
    // Update prediction input
    [bar updateInputText:[word lowercaseString]];
}

- (void)handleSpaceDoulbeTap
{
    // Check string for double tap allowance
    NSString* check = [[NSString alloc] init];
    
    if (self.textDocumentProxy.documentContextBeforeInput != nil)
        check = [NSString stringWithString:self.textDocumentProxy.documentContextBeforeInput];
    
    if (check.length >= 3)
        check = [check substringFromIndex:check.length - 3];
    
    if (check.length == 3 && ![check isEqualToString:@"   "] && [[check substringFromIndex:check.length - 2] isEqualToString:@"  "])
    {
        // Remove last two space
        [self alhpaInputRemoveCharacter];
        [self alhpaInputRemoveCharacter];
        
        // Add ending character followed by space
        [self alphaInputDelegateMethod:@": "];
    }
}

- (void)toShifted
{
    Alpha* view = nil;
    for (UIView *subUIView in self.view.subviews) {
        if ([subUIView isKindOfClass:[Alpha class]])
        {
            Alpha* tmp = (Alpha*)subUIView;
            // Check if we found the proper button
            BOOL properView = (tmp.tag == kAlpha);
            if (properView == YES)
            {
                view = tmp;
                break;
            }
        }
    }
    
    // Switch to shited mode
    [view toShiftMode];
}

- (void)toShiftedWithCondition
{
    Alpha* view = nil;
    for (UIView *subUIView in self.view.subviews) {
        if ([subUIView isKindOfClass:[Alpha class]])
        {
            Alpha* tmp = (Alpha*)subUIView;
            // Check if we found the proper button
            BOOL properView = (tmp.tag == kAlpha);
            if (properView == YES)
            {
                view = tmp;
                break;
            }
        }
    }
    
    if (view.alphaMode == kNormal)
    {
        // Switch to shited mode
        [view toShiftMode];
    }
}

- (void)checkSpecialArmenianGrammar
{
    NSString* text = [[NSString alloc] init];
    if (self.textDocumentProxy.documentContextBeforeInput != nil)
        text = [NSString stringWithString:self.textDocumentProxy.documentContextBeforeInput];
    
    // Check for switching to shited mode
    if (self.isAutoCapitalizationEnabled && [text hasSuffix:@": "])
    {
        // Switch to shited mode
        [self toShifted];
    }
    
    // Check for automatic comma edition
    if (![text isEqualToString:@" որ "]         &&
        [text hasSuffix:@" որ "]                && ![text hasSuffix:@", որ "] &&
        ![text hasSuffix:@"ոնց որ "]            && ![text hasSuffix:@"Ոնց որ "] &&
        ![text hasSuffix:@"մինչև որ "]           && ![text hasSuffix:@"Մինչև որ "] &&
        ![text hasSuffix:@"չնայած որ "]          && ![text hasSuffix:@"Չնայած որ "] &&
        ![text hasSuffix:@"քանի որ "]           && ![text hasSuffix:@"Քանի որ "] &&
        ![text hasSuffix:@"հենց որ "]            && ![text hasSuffix:@"Հենց որ "] &&
        ![text hasSuffix:@"մանավանդ որ "]       && ![text hasSuffix:@"Մանավանդ որ "] &&
        ![text hasSuffix:@"երբ որ "]             && ![text hasSuffix:@"Երբ որ "] &&
        ![text hasSuffix:@"ինչ որ "]             && ![text hasSuffix:@"Ինչ որ "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", որ "];
    }

    if (![text isEqualToString:@" թե "]         &&
        [text hasSuffix:@" թե "]                && ![text hasSuffix:@", թե "] &&
        ![text hasSuffix:@"ո՞նց թե "]            && ![text hasSuffix:@"Ո՞նց թե "] &&
        ![text hasSuffix:@"ոնց թե "]            && ![text hasSuffix:@"Ոնց թե "] &&
        ![text hasSuffix:@"ինչպե՞ս թե "]            && ![text hasSuffix:@"Ինչպե՞ս թե "] &&
        ![text hasSuffix:@"ինչպես թե "]            && ![text hasSuffix:@"Ինչպես թե "] &&
        ![text hasSuffix:@"կարծես թե "]           && ![text hasSuffix:@"Կարծես թե "] &&
        ![text hasSuffix:@"կարծեք թե "]           && ![text hasSuffix:@"Կարծեք թե "] &&
        ![text hasSuffix:@"ասես թե "]          && ![text hasSuffix:@"Ասես թե "] &&
        ![text hasSuffix:@"ոչ թե "]           && ![text hasSuffix:@"Ոչ թե "] &&
        ![text hasSuffix:@"ո՛չ թե "]           && ![text hasSuffix:@"Ո՛չ թե "] &&
        ![text hasSuffix:@"իբրև թե "]            && ![text hasSuffix:@"Իբրև թե "] &&
        ![text hasSuffix:@"իսկ թե "]       && ![text hasSuffix:@"Իսկ թե "] &&
        ![text hasSuffix:@"իբր թե "]       && ![text hasSuffix:@"Իբր թե "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", թե "];
    }
    
    if (![text isEqualToString:@" երբ "] &&
        [text hasSuffix:@" երբ "] && ![text hasSuffix:@", երբ "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", երբ "];
    }
    
    if (![text isEqualToString:@" բայց "] &&
        [text hasSuffix:@" բայց "] && ![text hasSuffix:@", բայց "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", բայց "];
    }
    
    if (![text isEqualToString:@" իսկ "] &&
        [text hasSuffix:@" իսկ "] && ![text hasSuffix:@", իսկ "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", իսկ "];
    }
    
    if (![text isEqualToString:@" եթե "] &&
        [text hasSuffix:@" եթե "] && ![text hasSuffix:@", եթե "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", եթե "];
    }
    
    if (![text isEqualToString:@" սակայն "] &&
        [text hasSuffix:@" սակայն "] && ![text hasSuffix:@", սակայն "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", սակայն "];
    }
    
    if (![text isEqualToString:@" մինչդեռ "] &&
        [text hasSuffix:@" մինչդեռ "] && ![text hasSuffix:@", մինչդեռ "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", մինչդեռ "];
    }
    
    if (![text isEqualToString:@" թեև "] &&
        [text hasSuffix:@" թեև "] && ![text hasSuffix:@", թեև "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", թեև "];
    }
    
    if (![text isEqualToString:@" որպեսզի "] &&
        [text hasSuffix:@" որպեսզի "] && ![text hasSuffix:@", որպեսզի "])
    {
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy deleteBackward];
        [self.textDocumentProxy insertText:@", որպեսզի "];
    }
}

- (void)toNormal
{
    Alpha* view = nil;
    for (UIView *subUIView in self.view.subviews) {
        if ([subUIView isKindOfClass:[Alpha class]])
        {
            Alpha* tmp = (Alpha*)subUIView;
            // Check if we found the proper button
            BOOL properView = (tmp.tag == kAlpha);
            if (properView == YES)
            {
                view = tmp;
                break;
            }
        }
    }
    
    // Switch to normal mode
    [view toNormalMode];
}

- (void)toNormalWithCondition
{
    Alpha* view = nil;
    for (UIView *subUIView in self.view.subviews) {
        if ([subUIView isKindOfClass:[Alpha class]])
        {
            Alpha* tmp = (Alpha*)subUIView;
            // Check if we found the proper button
            BOOL properView = (tmp.tag == kAlpha);
            if (properView == YES)
            {
                view = tmp;
                break;
            }
        }
    }
    
    if (view.alphaMode == kShifted)
    {
        // Switch to normal mode
        [view toNormalMode];
    }
}

#pragma mark AlphaInputDelegate

- (void) alphaSpecialKeyInputDelegateMethod:(NSInteger)tag
{
    if (tag == kAlphaDismissButton)
        [self dismissKeyboard];
    if (tag == kAlphaGlobeButton)
        [self advanceToNextInputMode];
    if (tag == kAlphaSpaceDouble)
        [self handleSpaceDoulbeTap];
}

- (void) alphaInputDelegateMethod: (NSString *) key
{
    // Insert typed text
    [self.textDocumentProxy insertText:key];
    
    // Gramatical check for adding comma for special words
    [self checkSpecialArmenianGrammar];
    
    if (self.isPredictionEnabled == YES)
    {
        // Check string
        NSString* check = [[NSString alloc] init];
        
        // Update currently typed word
        if (self.textDocumentProxy.documentContextBeforeInput != nil)
            currentWord = [NSString stringWithString:self.textDocumentProxy.documentContextBeforeInput];
        else
            currentWord = @"";
        
        // Update prediction input
        [self updatePredictionInput];
    }
}

- (void) alhpaInputRemoveCharacter
{
    // Update keyboard state
    if (self.textDocumentProxy.documentContextBeforeInput != nil)
    {
        NSString* text = self.textDocumentProxy.documentContextBeforeInput;
        
        if (text.length > 1)
        {
            isUpperCase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[text characterAtIndex:[text length] - 1]];
        }
    }
    
    // Remove a character
    [self.textDocumentProxy deleteBackward];
    
    if (self.isPredictionEnabled == YES)
    {
        // Update currently typed word
        if (self.textDocumentProxy.documentContextBeforeInput != nil)
            currentWord = [NSString stringWithString:self.textDocumentProxy.documentContextBeforeInput];
        else
            currentWord = @"";
        
        // Update prediction input
        [self updatePredictionInput];
    }
}

- (void) alhpaInputBackspaceReleased
{
    if (isUpperCase == YES)
    {
        [self toShiftedWithCondition];
    }
    else
    {
        [self toNormalWithCondition];
    }
}

#pragma mark PredictiveBarDelegate

- (void) spellerInputDelegateMethod:(NSString *)key Word:(NSString*)word;
{
    // Return immediately if an empty option has been clicked
    if ([key isEqualToString:@""])
        return;
        
    // Remove last word
    for(size_t i = 0; i < word.length; ++i)
    {
        [self.textDocumentProxy deleteBackward];
    }
    
    // Add option key and space at the end
    [self.textDocumentProxy insertText:[NSString stringWithFormat:@"%@ ", key]];
    
    // Update currently typed word
    currentWord = [NSString stringWithString:self.textDocumentProxy.documentContextBeforeInput];
    
    // Update predictive option
    [self updatePredictionInput];
}

@end
