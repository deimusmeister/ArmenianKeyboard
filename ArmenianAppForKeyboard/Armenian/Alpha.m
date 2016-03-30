//
//  Alpha.m
//  ArmenianKeyboard
//
//  Created by Levon Poghosyan on 13/01/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "Alpha.h"
#import "Colors.h"
#import "CYRKeyboardButton.h"

// UI debugging flag
#define kDebug              0.0

// States of the alpha keybaord
#define kNormal           1     // Lowercase
#define kShifted          2     // Shifted
#define kCapslock         3     // Capslocked

@implementation Alpha

@synthesize delegate;
@synthesize alphaMode;

- (id)init
{
    if (self = [super init])
    {
        // Set the border color for alpha keyboard
        self.layer.borderColor = [UIColor colorWithRed:255.f/255.f green:0.f/255.f blue:0.f/255.f alpha:kDebug].CGColor;
        self.layer.borderWidth = 1.0f;
        
        // Show the default layout
        [self addLowerCaseLayout];
        
        // Set the alpha keyboard mode to normal (lowercase)
        self.alphaMode = kNormal;
    }
    return self;
}

- (void)addLowerCaseLayout
{
    // Cleanup all subviews
    for (UIView *subUIView in self.subviews) {
        [subUIView removeFromSuperview];
    }
    
    // Row 1
    UIView* row1 = [self createRow:@[ @"է", @"թ", @"փ", @"ձ", @"ջ", @"և", @"ր", @"չ", @"ճ", @"ժ", @"շ" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:kDebug];
    
    // Row 2
    UIView* row2 = [self createRow:@[ @"ք", @"ո", @"ե", @"ռ", @"տ", @"ը", @"ւ", @"ի", @"օ", @"պ", @"խ" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 3
    UIView* row3 = [self createRow:@[ @"ա", @"ս", @"դ", @"ֆ", @"գ", @"հ", @"յ", @"կ", @"լ", @"ծ" ]
                           options:nil OffsetLeft:0.05 OffsetLeft:0.05];
    row3.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 4
    UIView* row4 = [self createRow:@[ @"զ", @"ղ", @"ց", @"վ", @"բ", @"ն", @"մ" ]
                           options:nil OffsetLeft:0.11 OffsetLeft:0.11];
    row4.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:kDebug];
    
    // Add delete button
    [self addDeleteButtonInRow:row4 sideOffset:0.0];
    
    // Add shift button
    [self addShiftButtonInRow:row4 sideOffset:0.0];
    
    // Row 5
    UIView* row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.325 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (123)
    [self addNumbersButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add search button
    [self addSearchButtonInRow:row5 sideOffset:0.0];
    
    // Add dot button
    [self addDotButtonInRow:row5 sideOffset:0.0];
    
    // Vertical constraints
    NSDictionary* views = NSDictionaryOfVariableBindings( row1, row2, row3, row4, row5 );
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                          @"V:|-4-[row1]-4-[row2(==row1)]-4-[row3(==row2)]-4-[row4(==row3)]-4-[row5(==row4)]-3-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void)addUpperCaseLayout
{
    // Cleanup all subviews
    for (UIView *subUIView in self.subviews) {
        [subUIView removeFromSuperview];
    }
    
    // Row 1
    UIView* row1 = [self createRow:@[ @"Է", @"Թ", @"Փ", @"Ձ", @"Ջ", @"և", @"Ր", @"Չ", @"Ճ", @"Ժ", @"Շ" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:kDebug];
    
    // Row 2
    UIView* row2 = [self createRow:@[ @"Ք", @"Ո", @"Ե", @"Ռ", @"Տ", @"Ը", @"Ւ", @"Ի", @"Օ", @"Պ", @"Խ" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 3
    UIView* row3 = [self createRow:@[ @"Ա", @"Ս", @"Դ", @"Ֆ", @"Գ", @"Հ", @"Յ", @"Կ", @"Լ", @"Ծ" ]
                           options:nil OffsetLeft:0.05 OffsetLeft:0.05];
    row3.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 4
    UIView* row4 = [self createRow:@[ @"Զ", @"Ղ", @"Ց", @"Վ", @"Բ", @"Ն", @"Մ"]
                           options:nil  OffsetLeft:0.11 OffsetLeft:0.11];
    row4.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:kDebug];
    
    // Add delete button
    [self addDeleteButtonInRow:row4 sideOffset:0.0];
    
    // Add shift button
    [self addShiftButtonInRow:row4 sideOffset:0.0];
    
    // Row 5
    UIView* row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.325 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (123)
    [self addNumbersButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add search button
    [self addSearchButtonInRow:row5 sideOffset:0.0];
    
    // Add dot button
    [self addDotButtonInRow:row5 sideOffset:0.0];
    
    // Vertical constraints
    NSDictionary* views = NSDictionaryOfVariableBindings( row1, row2, row3, row4, row5 );
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                          @"V:|-4-[row1]-4-[row2(==row1)]-4-[row3(==row2)]-4-[row4(==row3)]-4-[row5(==row4)]-3-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (UIView*)createRow:(NSArray*)titles options:(NSArray*)options OffsetLeft:(CGFloat)offsetLeft OffsetLeft:(CGFloat)offsetRight
{
    UIView* row = [[UIView alloc] init];
    row.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:row];
    
    // Left constraint
    NSLayoutConstraint *rowLeftConstraint = [NSLayoutConstraint constraintWithItem:row
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0 constant:3.0];
    
    [self addConstraint:rowLeftConstraint];
    
    // Right constraint
    NSLayoutConstraint *rowRightConstraint = [NSLayoutConstraint constraintWithItem:row
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0 constant:-3.0];
    
    [self addConstraint:rowRightConstraint];
    
    // If the number of options is not equal to the number of titles ignore options
    if (options != nil && titles.count != options.count)
        options = nil;
    
    // Create buttons
    NSMutableArray* buttons = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < titles.count; i++)
    {
        if ([[titles objectAtIndex:i] isEqualToString:@"ԲԱՑԱՏ"])
        {
            // Create a standard UIButton for space
            UIButton* sbutton = [[UIButton alloc] init];
            sbutton.translatesAutoresizingMaskIntoConstraints = NO;
            [row addSubview:sbutton];
            
            // Register touch events
            [sbutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
            [sbutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
            
            [sbutton setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            sbutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:16.0];
            [sbutton setBackgroundColor:[Colors buttonBackgroundColor]];
            [sbutton setTitleColor:[Colors buttonTextBackgroundColor] forState:UIControlStateNormal];
            sbutton.layer.cornerRadius = 5;
            sbutton.tag = kAlhpaSpace;
            
            // Add to buttons list
            [buttons addObject:sbutton];
        }
        else
        {
            CYRKeyboardButton* button;
            button = [CYRKeyboardButton new];
            
            // Register button click handler
            button.delegate = self;
            
            button.translatesAutoresizingMaskIntoConstraints = NO;
            [row addSubview:button];
            
            // Button specific colors
            UIColor* buttonBackgroundColor = [Colors buttonBackgroundColor];
            UIColor* buttonTextColor = [Colors buttonTextBackgroundColor];
            
            // Button properties
            button.keyColor = buttonBackgroundColor;
            button.keyTextColor = buttonTextColor;
            button.keyHighlightedColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
            
            button.input = [titles objectAtIndex:i];
            
            if (options == nil)
            {
                button.font = [UIFont fontWithName:@"ArianAMU" size:20.0];
            }
            else
            {
                // Set the button text
                NSMutableArray *letterArray = [NSMutableArray array];
                NSString *letters = [options objectAtIndex:i];
                [letters enumerateSubstringsInRange:NSMakeRange(0, [letters length])
                                            options:(NSStringEnumerationByComposedCharacterSequences)
                                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                             [letterArray addObject:substring];
                                         }];
                button.inputOptions = [letterArray copy];
            }
            // Add into buttons list
            [buttons addObject:button];
        }
    }
    
    // Add button contraints
    [self addButtonConstraints:buttons inView:row offsetLeft:offsetLeft offsetRight:offsetRight];
    
    return row;
}

- (void)addRowSizeOffsetsInView:(UIView*)containerView Left:(UIView*)emptyLefttView Right:(UIView*)emptyRightView
               offsetFactorLeft:(CGFloat)offsetLeft offsetFactorRight:(CGFloat)offsetRight
{
    // Left constraint
    NSLayoutConstraint *emptyLeftConstraint = [NSLayoutConstraint constraintWithItem:emptyLefttView
                                                                           attribute:NSLayoutAttributeLeft
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeLeft
                                                                          multiplier:1.0 constant:0];
    [containerView addConstraint:emptyLeftConstraint];
    
    // Width constraint
    NSLayoutConstraint *emptyLWidthConstraint = [NSLayoutConstraint constraintWithItem:emptyLefttView
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:offsetLeft constant:0];
    [containerView addConstraint:emptyLWidthConstraint];
    
    // Heigh constraint
    NSLayoutConstraint *emptyLHeightConstraint = [NSLayoutConstraint constraintWithItem:emptyLefttView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeHeight
                                                                             multiplier:1.0 constant:0];
    [containerView addConstraint:emptyLHeightConstraint];
    
    // Top constraint
    NSLayoutConstraint *emptyLTopConstraint = [NSLayoutConstraint constraintWithItem:emptyLefttView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0];
    [containerView addConstraint:emptyLTopConstraint];
    
    
    
    
    // Right constraint
    NSLayoutConstraint *emptyRightConstraint = [NSLayoutConstraint constraintWithItem:emptyRightView
                                                                            attribute:NSLayoutAttributeRight
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0 constant:0];
    [containerView addConstraint:emptyRightConstraint];
    
    // Width constraint
    NSLayoutConstraint *emptyRWidthConstraint = [NSLayoutConstraint constraintWithItem:emptyRightView
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:offsetRight constant:0];
    [containerView addConstraint:emptyRWidthConstraint];
    
    // Height constraint
    NSLayoutConstraint *emptyRHeightConstraint = [NSLayoutConstraint constraintWithItem:emptyRightView
                                                                              attribute:NSLayoutAttributeHeight
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeHeight
                                                                             multiplier:1.0 constant:0];
    [containerView addConstraint:emptyRHeightConstraint];
    
    // Top constraint
    NSLayoutConstraint *emptyRTopConstraint = [NSLayoutConstraint constraintWithItem:emptyRightView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0];
    [containerView addConstraint:emptyRTopConstraint];
}

- (void)addButtonConstraints:(NSMutableArray*)buttons inView:(UIView*)containerView offsetLeft:(CGFloat)offsetLeft
                 offsetRight:(CGFloat)offsetRight
{
    // Define empty side uiviews
    UIView* emptyLefttView = [[UIView alloc] init];
    emptyLefttView.backgroundColor = [UIColor colorWithRed:100.f/255.f green:0.f/255.f blue:0.f/255.f alpha:kDebug];
    emptyLefttView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:emptyLefttView];
    
    UIView* emptyRightView = [[UIView alloc] init];
    emptyRightView.backgroundColor = [UIColor colorWithRed:100.f/255.f green:0.f/255.f blue:0.f/255.f alpha:kDebug];
    emptyRightView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:emptyRightView];
    
    // Add empty side offset constraints
    [self addRowSizeOffsetsInView:containerView Left:emptyLefttView Right:emptyRightView
                 offsetFactorLeft:offsetLeft offsetFactorRight:offsetRight];
    
    for (NSUInteger i = 0; i < buttons.count; i++)
    {
        UIControl* button = (UIControl*)[buttons objectAtIndex:i];
        
        // Width constraint
        if (i != 0)
        {
            UIControl* pbutton = (UIControl*)[buttons objectAtIndex:i - 1];
            NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                     attribute:NSLayoutAttributeWidth
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:pbutton
                                                                                     attribute:NSLayoutAttributeWidth
                                                                                    multiplier:1.0 constant:0.0];
            [containerView addConstraint:buttonWidthConstraint];
        }
        
        // Left constraint
        if (i == 0)
        {
            NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                    attribute:NSLayoutAttributeLeft
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:emptyLefttView
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1.0 constant:0];
            [containerView addConstraint:buttonLeftConstraint];
        }
        else
        {
            UIButton* lbutton = (UIButton*)[buttons objectAtIndex:i - 1];
            NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                    attribute:NSLayoutAttributeLeft
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:lbutton
                                                                                    attribute:NSLayoutAttributeRight
                                                                                   multiplier:1.0 constant:-3.0];
            [containerView addConstraint:buttonLeftConstraint];
        }
        
        // Right constraint
        if (i == buttons.count - 1)
        {
            NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                     attribute:NSLayoutAttributeRight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:emptyRightView
                                                                                     attribute:NSLayoutAttributeLeft
                                                                                    multiplier:1.0 constant:0];
            [containerView addConstraint:buttonRightConstraint];
        }
        else
        {
            UIButton* rbutton = (UIButton*)[buttons objectAtIndex:i + 1];
            NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                     attribute:NSLayoutAttributeRight
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:rbutton
                                                                                     attribute:NSLayoutAttributeLeft
                                                                                    multiplier:1.0 constant:-3.0];
            [containerView addConstraint:buttonRightConstraint];
        }
        
        // Bottom constraint
        NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:containerView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1.0 constant:0.0];
        
        [containerView addConstraint:buttonBottomConstraint];
        
        // Top constraint
        NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                               attribute:NSLayoutAttributeTop
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:containerView
                                                                               attribute:NSLayoutAttributeTop
                                                                              multiplier:1.0 constant:0.0];
        [containerView addConstraint:buttonTopConstraint];
        
    }
}

- (void)buttonUpInside:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    // Handle corresponding button press
    switch (button.tag) {
        case kAlphaDelete:
        {
            // Update delete button icon and background color
            [button setImage:[UIImage imageNamed:@"Backspace.png"] forState:UIControlStateNormal];
            
            // Update background color
            UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Remove a character
            [delegate alhpaInputRemoveCharacter];
        }
            break;
            
        case kAlphaEnter:
        {
            // Button specific colors
            UIColor* buttonBackgroundColor = [Colors buttonBackgroundColor];
            UIColor* buttonTextColor = [Colors buttonTextBackgroundColor];
            
            // Button properties
            [button setBackgroundColor:buttonBackgroundColor];
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
            button.tintColor = buttonTextColor;
            
            // Insert return character
            [delegate alphaInputDelegateMethod:@"\n"];
        }
            break;
            
        case kAlphaNumber:
        {
            // Update delete button icon and background color
            [button setImage:[UIImage imageNamed:@"Numbers.png"] forState:UIControlStateNormal];
            
            // Update background color
            UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Switch to numeric keyboard
            [delegate alphaSpecialKeyInputDelegateMethod:kAlphaNumber];
        }
            break;
        case kAlhpaSpace:
        {
            // Update space botton colors
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[Colors buttonTextBackgroundColor] forState:UIControlStateNormal];
            
            // Forward to input handler
            [delegate alphaInputDelegateMethod:@" "];
        }
            break;
        case kAlphaGlobeButton:
        {
            [delegate alphaSpecialKeyInputDelegateMethod:kAlphaGlobeButton];
        }
            break;
            
        default:
            // Forward to key input handler
            [delegate alphaInputDelegateMethod:button.titleLabel.text];
            break;
    }
}

- (void)buttonDown:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    // Handle corresponding button press
    switch (button.tag) {
        case kAlphaDelete:
        {
            // Update delete button icon and background color
            [button setImage:[UIImage imageNamed:@"BackspaceSelected.png"] forState:UIControlStateNormal];
            
            // Update background color
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlphaEnter:
        {
            // Button specific colors
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
            UIColor* buttonTextColor = [UIColor colorWithRed:173.f/255.f green:201.f/255.f blue:114.f/255.f alpha:1.f];
            
            // Button properties
            [button setBackgroundColor:buttonBackgroundColor];
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
            button.tintColor = buttonTextColor;
        }
            break;
            
        case kAlphaNumber:
        {
            // Update delete button icon and background color
            [button setImage:[UIImage imageNamed:@"NumbersSelected.png"] forState:UIControlStateNormal];
            
            // Update background color
            UIColor* buttonBackgroundColor = [UIColor whiteColor];
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlhpaSpace:
        {
            // Button specific color
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
            UIColor* buttonTextColor = [UIColor colorWithRed:173.f/255.f green:201.f/255.f blue:114.f/255.f alpha:1.f];
            
            // Update space botton colors
            [button setBackgroundColor:buttonBackgroundColor];
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

- (void)handleShiftDoubleTap
{
    if (alphaMode == kNormal || alphaMode == kShifted)
    {
        // Update the keyboard
        [self addUpperCaseLayout];
        
        // Set the alpha keyboard mode
        self.alphaMode = kCapslock;
        
        UIButton* ebutton = [self viewWithTag:kAlphaShift];
        if (ebutton != nil)
        {
            // Update the shift button icon
            [ebutton setImage:[UIImage imageNamed:@"ShiftCapslock.png"] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
            [ebutton setBackgroundColor:buttonBackgroundColor];
        }
    }
}

- (void)handleShiftSingleTap
{
    if (alphaMode == kNormal)
    {
        // Update the keyboard layout
        [self addUpperCaseLayout];
        
        // Set the alpha keyboard mode
        self.alphaMode = kShifted;
        
        UIButton* ebutton = [self viewWithTag:kAlphaShift];
        if (ebutton != nil)
        {
            // Update the shift button icon
            [ebutton setImage:[UIImage imageNamed:@"ShiftShifted.png"] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:173.f/255.f green:201.f/255.f blue:114.f/255.f alpha:1.f];
            [ebutton setBackgroundColor:buttonBackgroundColor];
        }
    }
    else if (alphaMode == kShifted || alphaMode == kCapslock)
    {
        // Update the keyboard layout
        [self addLowerCaseLayout];
        
        // Set the alhpha keyboard mode
        self.alphaMode = kNormal;
        
        UIButton* ebutton = [self viewWithTag:kAlphaShift];
        if (ebutton != nil)
        {
            // Update the shift button icon
            [ebutton setImage:[UIImage imageNamed:@"Shift.png"] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [UIColor colorWithRed:173.f/255.f green:201.f/255.f blue:114.f/255.f alpha:1.f];
            [ebutton setBackgroundColor:buttonBackgroundColor];
        }
    }
}

- (void)onTap:(id)sender withEvent:(UIEvent*)event
{
    UITouch* touch = [[event allTouches] anyObject];
    
    UIButton* button = (UIButton*)sender;
    
    // Handle corresponding button press
    switch (button.tag)
    {
        case kAlphaShift:
            if (touch.tapCount == 2)
            {
                [self handleShiftDoubleTap];
            }
            else if (touch.tapCount == 1)
            {
                [self handleShiftSingleTap];
            }
            break;
        default:
            break;
    }
}

- (void)addDeleteButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with m, M, ' title
    CYRKeyboardButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[CYRKeyboardButton class]])
        {
            CYRKeyboardButton* tmp = (CYRKeyboardButton*)subUIView;
            // Check if found the proper buttton
            NSString* titleText = tmp.input;
            BOOL properButton = [titleText isEqualToString:@"մ"] ||
            [titleText isEqualToString:@"Մ"] ||
            [titleText isEqualToString:@"'"];
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaDelete;
    [ebutton setImage:[UIImage imageNamed:@"Backspace.png"] forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handlers
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Right constraint
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0 constant:-offset];
    [containerView addConstraint:buttonRightConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10f constant:offset];
    [containerView addConstraint:buttonWidthConstraint];
    
}

- (void)addEnterButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with space title
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            if ([tmp.titleLabel.text isEqualToString:@"ԲԱՑԱՏ"])
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaEnter;
    [ebutton setTitle:@"ՄՈՒՏՔ" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:16.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Right constraint
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeRight
                                                                            multiplier:1.0 constant:-offset];
    [containerView addConstraint:buttonRightConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.23f constant:0];
    [containerView addConstraint:buttonWidthConstraint];
}

- (void)addNumbersButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with space title
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = [tmp.titleLabel.text isEqualToString:@"ԲԱՑԱՏ"] || [tmp.titleLabel.text isEqualToString:@"."];
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaNumber;
    [ebutton setImage:[UIImage imageNamed:@"Numbers.png"] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0 constant:offset];
    [containerView addConstraint:buttonLeftConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10f constant:0];
    [containerView addConstraint:buttonWidthConstraint];
}

- (void)addGlobeButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with numbers button
    UIButton* numbutton = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = (tmp.tag == kAlphaNumber);
            if (properButton == YES)
            {
                numbutton = tmp;
                break;
            }
        }
    }

    if (numbutton == nil)
        return;

    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaGlobeButton;
    [ebutton setImage:[UIImage imageNamed:@"Globe.png"] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];

    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];

    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:173.f/255.f green:201.f/255.f blue:114.f/255.f alpha:1.f];

    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];

    [containerView addConstraint:buttonBottomConstraint];

    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];

    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:numbutton
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0 constant:3.0];
    [containerView addConstraint:buttonLeftConstraint];

    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10 constant:0.0];
    [containerView addConstraint:buttonWidthConstraint];
    
}

- (void)addSearchButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with numbers button
    UIControl* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIControl class]])
        {
            UIControl* tmp = (UIControl*)subUIView;
            // Check if we found the proper button
            BOOL properButton = (tmp.tag == kAlphaGlobeButton);
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaSearchButton;
    [ebutton setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:button
                                                                            attribute:NSLayoutAttributeRight
                                                                           multiplier:1.0 constant:3.0];
    [containerView addConstraint:buttonLeftConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10 constant:0.0];
    [containerView addConstraint:buttonWidthConstraint];
    
}

- (void)addDotButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with numbers button
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = (tmp.tag == kAlphaEnter);
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    CYRKeyboardButton *ebutton = [CYRKeyboardButton new];
    ebutton.tag = kAlphaDotButton;
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    ebutton.input = @"՞";
    ebutton.inputOptions = @[@",", @":", @"?", @"!"];
    
    // Register button click handler
    ebutton.delegate = self;
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonBackgroundColor];
    UIColor* buttonTextColor = [Colors buttonTextBackgroundColor];
    
    // Button properties
    ebutton.keyColor = buttonBackgroundColor;
    ebutton.keyShadowColor = buttonBackgroundColor;
    ebutton.keyTextColor = buttonTextColor;
    ebutton.keyHighlightedColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    ebutton.font = [UIFont fontWithName:@"ArianAMU" size:23.0];
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Right constraint
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:button
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0 constant:-3.0];
    [containerView addConstraint:buttonRightConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10 constant:0.0];
    [containerView addConstraint:buttonWidthConstraint];
    
}

- (void)addABCButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with space title
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = [tmp.titleLabel.text isEqualToString:@"ԲԱՑԱՏ"];
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaABC;
    [ebutton setTitle:@"ABC" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0 constant:offset];
    [containerView addConstraint:buttonLeftConstraint];
    
    // Right constraint
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:button
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0 constant:-2.0];
    [containerView addConstraint:buttonRightConstraint];
    
}

- (void)addShiftButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with Z, z title
    CYRKeyboardButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[CYRKeyboardButton class]])
        {
            CYRKeyboardButton* tmp = (CYRKeyboardButton*)subUIView;
            NSString* titleText = tmp.input;
            // Check if we found the proper button
            BOOL properButton = [titleText isEqualToString:@"զ"] ||
            [titleText isEqualToString:@"Զ"];
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaShift;
    [ebutton setImage:[UIImage imageNamed:@"Shift.png"] forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Add double and single tap handlers
    [ebutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [ebutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0 constant:offset];
    [containerView addConstraint:buttonLeftConstraint];
    
    // Width constraint
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:0.10f constant:0];
    [containerView addConstraint:buttonWidthConstraint];
    
}

- (void)addOptionButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with . title
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = [tmp.titleLabel.text isEqualToString:@"."];
            if (properButton == YES)
            {
                button = tmp;
                break;
            }
        }
    }
    
    if (button == nil)
        return;
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaOption;
    [ebutton setTitle:@"#+=" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [Colors buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:12.0];
    ebutton.layer.cornerRadius = 5;
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:containerView
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [containerView addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:containerView
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [containerView addConstraint:buttonTopConstraint];
    
    // Left constraint
    NSLayoutConstraint *buttonLeftConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                            attribute:NSLayoutAttributeLeft
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:containerView
                                                                            attribute:NSLayoutAttributeLeft
                                                                           multiplier:1.0 constant:offset];
    [containerView addConstraint:buttonLeftConstraint];
    
    // Right constraint
    NSLayoutConstraint *buttonRightConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeRight
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:button
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1.0 constant:-2.0];
    [containerView addConstraint:buttonRightConstraint];
    
}

#pragma mark CYRKeyboarBUttonInputDelegate

- (void) cyrKeyboardButtonInputDelegateMethod: (NSString *)key
{
    [delegate alphaInputDelegateMethod:key];
}

@end
