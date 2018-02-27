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
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ios_detect.h"

// UI debugging flag
#define kDebug              0.0

// Target definition
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

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
        
        // Set background color
        self.backgroundColor = (__bridge UIColor * _Nullable)([[Colors sharedManager] backgroundColor]);
        
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
    UIView* row5;
    if (IPAD)
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.445];
    else
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (123)
    [self addNumbersButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add dismiss button (only for iPad)
    if (IPAD)
        [self addDismissButtonInRow:row5 sideOffset:0.0];
    
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
    UIView* row5;
    if (IPAD)
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.445];
    else
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (123)
    [self addNumbersButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add dismiss button (only for iPad)
    if (IPAD)
        [self addDismissButtonInRow:row5 sideOffset:0.0];
    
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

- (void)addNumericLayout
{
    // Cleanup all subviews
    for (UIView *subUIView in self.subviews) {
        [subUIView removeFromSuperview];
    }
    
    // Row 1
    UIView* row1 = [self createRow:@[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:kDebug];
    
    // Row 2
    UIView* row2 = [self createRow:@[ @"-", @"/", @":", @";", @"(", @")", @"՜", @"&", @"@", @"\"" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 3
    UIView* row3 = [self createRow:@[ @"՞", @"`", @"«", @"»", @"՛", @"😊", @"😉", @"😄"]
                           options:nil OffsetLeft:0.05 OffsetLeft:0.05];
    row3.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 4
    UIView* row4 = [self createRow:@[ @".", @",", @"?", @"!", @"‘" ]
                           options:nil  OffsetLeft:0.11 OffsetLeft:0.11];
    row4.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:kDebug];
    
    // Add delete button
    [self addDeleteButtonInRow:row4 sideOffset:0.0];
    
    // Add symbolic button
    [self addSymbolicButtonInRow:row4 sideOffset:0.0];
    
    // Row 5
    UIView* row5;
    if (IPAD)
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.445];
    else
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (ԱԲԳ)
    [self addABCButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add dismiss button (only for iPad)
    if (IPAD)
        [self addDismissButtonInRow:row5 sideOffset:0.0];
    
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

- (void)addSymbolicLayout
{
    // Cleanup all subviews
    for (UIView *subUIView in self.subviews) {
        [subUIView removeFromSuperview];
    }
    
    // Row 1
    UIView* row1 = [self createRow:@[ @"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"=" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:kDebug];
    
    // Row 2
    UIView* row2 = [self createRow:@[ @"_", @"\\", @"|", @"~", @"<", @">", @"$", @"£", @"€", @"֏" ]
                           options:nil OffsetLeft:0.0 OffsetLeft:0.0];
    row2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 3
    UIView* row3 = [self createRow:@[ @"՞", @"`", @"«", @"»", @"՛", @"😊", @"😉", @"😄"]
                           options:nil OffsetLeft:0.05 OffsetLeft:0.05];
    row3.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:kDebug];
    
    // Row 4
    UIView* row4 = [self createRow: @[ @".", @",", @"?", @"!", @"‘" ]
                           options:nil  OffsetLeft:0.11 OffsetLeft:0.11];
    row4.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:kDebug];
    
    // Add delete button
    [self addDeleteButtonInRow:row4 sideOffset:0.0];
    
    // Add numbers button
    [self addNumbersButtonInRow:row4 sideOffset:0.0];
    
    // Row 5
    UIView* row5;
    if (IPAD)
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.445];
    else
        row5 = [self createRow:@[@"ԲԱՑԱՏ"] options:nil  OffsetLeft:0.215 OffsetLeft:0.345];
    row5.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:kDebug];
    
    // Add return button
    [self addEnterButtonInRow:row5 sideOffset:0.0];
    
    // Add numbers button (ԱԲԳ)
    [self addABCButtonInRow:row5 sideOffset:0.0];
    
    // Add globe button
    [self addGlobeButtonInRow:row5 sideOffset:0.0];
    
    // Add dismiss button (only for iPad)
    if (IPAD)
        [self addDismissButtonInRow:row5 sideOffset:0.0];
    
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
            [sbutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
//            [sbutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDown];
            [sbutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
            [sbutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
//            [sbutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDown];
            
            [sbutton setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            sbutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                                      size:12.0 + [[Colors sharedManager] keyboardFontSize]];
            [sbutton setBackgroundColor:[[Colors sharedManager] buttonBackgroundColor]];
            [sbutton setTitleColor:[[Colors sharedManager] buttonTextBackgroundColor] forState:UIControlStateNormal];
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
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
            
            // Button properties
            button.keyColor = buttonBackgroundColor;
            button.keyTextColor = buttonTextColor;
            button.keyShadowColor = [[Colors sharedManager] buttonShadowColor];
            
            button.input = [titles objectAtIndex:i];
            
            if (options == nil)
            {
                button.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:20.0 + [[Colors sharedManager] keyboardFontSize]];
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
            
            // Set the hit areas
            if (i == 0)
            {
                // Set the touch button areas
                [(CYRKeyboardButton*)button setHitTestEdgeInsets:UIEdgeInsetsMake(-2.f, -100.f, -2.f, -1.5f)];
            }
            else if (i == titles.count - 1)
            {
                // Set the touch button areas
                [(CYRKeyboardButton*)button setHitTestEdgeInsets:UIEdgeInsetsMake(-2.f, -1.5f, -2.f, -100.f)];
            }
            else{
                // Set the touch button areas
                [(CYRKeyboardButton*)button setHitTestEdgeInsets:UIEdgeInsetsMake(-2.f, -1.5f, -2.f, -1.5f)];
            }

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
    emptyLefttView.translatesAutoresizingMaskIntoConstraints = NO;
    emptyLefttView.userInteractionEnabled = NO;
    [containerView addSubview:emptyLefttView];
    [containerView sendSubviewToBack:emptyLefttView];
    
    UIView* emptyRightView = [[UIView alloc] init];
    emptyRightView.translatesAutoresizingMaskIntoConstraints = NO;
    emptyRightView.userInteractionEnabled = NO;
    [containerView addSubview:emptyRightView];
    [containerView sendSubviewToBack:emptyRightView];
    
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
            [button setImage:[[UIImage imageNamed:@"delete_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            UIColor* buttonTintColor = [[Colors sharedManager] buttonSpecialTintColor];
            [button setBackgroundColor:buttonBackgroundColor];
            button.tintColor = buttonTintColor;
            
            // Invalidate current timer
            [_TimerDeleteButton invalidate];
            _TimerDeleteButton = nil;
            
            // Update the state of the keyboard
            [delegate alhpaInputBackspaceReleased];
        }
            break;
            
        case kAlphaEnter:
        {
            // Button specific colors
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
            
            // Button properties
            [button setBackgroundColor:buttonBackgroundColor];
            [button setTitleColor:buttonTextColor forState:UIControlStateNormal];
            button.tintColor = buttonTextColor;
            
            // Insert return character
            [self forwardInput:@"\n"];
        }
            break;
            
        case kAlphaNumber:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Switch to numeric keyboard
            [self addNumericLayout];
            
            // Set the current mode
            self.alphaMode = kNumeric;
        }
            break;
            
        case kAlphaABC:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Switch to lowercase/uppercase layout
            [self addLowerCaseLayout];
            
            // Set the current mode
            self.alphaMode = kNormal;
        }
            break;
            
        case kAlhpaSymbolic:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Switch to symbolic keyboard
            [self addSymbolicLayout];
            
            // Set the current mode
            self.alphaMode = kSymbolic;
        }
            break;
            
        case kAlhpaSpace:
        {
            // Update space botton colors
            [button setBackgroundColor:[[Colors sharedManager] buttonBackgroundColor]];
            [button setTitleColor:[[Colors sharedManager] buttonTextBackgroundColor] forState:UIControlStateNormal];
        }
            break;
        case kAlphaGlobeButton:
        {
            [delegate alphaSpecialKeyInputDelegateMethod:kAlphaGlobeButton];
        }
            break;
        case kAlphaDismissButton:
        {
            [delegate alphaSpecialKeyInputDelegateMethod:kAlphaDismissButton];
        }
            break;
            
        default:
            // Forward to key input handler
            [self forwardInput:button.titleLabel.text];
            break;
    }
}

- (void)buttonDown:(id)sender
{
    // Make the click sound
    [self playSound];
    
    UIButton* button = (UIButton*)sender;
    
    // Handle corresponding button press
    switch (button.tag) {
        case kAlphaDelete:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            UIColor* buttonTintColor = [[Colors sharedManager] buttonSpecialTintSelectedColor];
            [button setBackgroundColor:buttonBackgroundColor];
            button.tintColor = buttonTintColor;
            
            // Remove a character
            [delegate alhpaInputRemoveCharacter];
            
            // Timer for delete on hold
            _TimerDeleteButton = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                  target:self
                                                                selector:@selector(triggerDelete:)
                                                                userInfo:nil
                                                                 repeats:NO];
        }
            break;
            
        case kAlphaEnter:
        {
            // Button specific colors
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            
            // Button properties
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlphaNumber:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlphaABC:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlhpaSymbolic:
        {
            // Update background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
            [button setBackgroundColor:buttonBackgroundColor];
        }
            break;
            
        case kAlhpaSpace:
        {
            // Button specific color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            
            // Update space botton colors
            [button setBackgroundColor:buttonBackgroundColor];
            
            // Forward space
            [self forwardInput:@" "];
            
            if (alphaMode == kNumeric || alphaMode == kSymbolic)
            {
                // Switch to normal mode
                [self toNormalMode];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)triggerDelete:(NSTimer*)timer
{
    // Invalidate current timer
    [_TimerDeleteButton invalidate];
    _TimerDeleteButton = nil;
    
    // Play click sound
    [self playSound];
    
    // Remove a character
    [delegate alhpaInputRemoveCharacter];
    
    if (_TimerDeleteButton == nil)
    {
        // Timer for delete on hold
        _TimerDeleteButton = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                              target:self
                                                            selector:@selector(triggerDelete:)
                                                            userInfo:nil
                                                             repeats:NO];
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
            [ebutton setImage:[[UIImage imageNamed:@"shift_lock_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColorSelected];
            UIColor* buttonTintColor = [[Colors sharedManager] buttonSpecialTintSelectedColor];
            [ebutton setBackgroundColor:buttonBackgroundColor];
            ebutton.tintColor = buttonTintColor;
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
            [ebutton setImage:[[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColorSelected];
            UIColor* buttonTintColor = [[Colors sharedManager] buttonSpecialTintSelectedColor];
            [ebutton setBackgroundColor:buttonBackgroundColor];
            ebutton.tintColor = buttonTintColor;
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
            [ebutton setImage:[[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            
            // Update the background color
            UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
            [ebutton setBackgroundColor:buttonBackgroundColor];
        }
    }
}

- (void)handleSpaceDoubleTap
{
    // Forward double space tap
    [delegate alphaSpecialKeyInputDelegateMethod:kAlphaSpaceDouble];
}

- (void)onTap:(id)sender withEvent:(UIEvent*)event
{
    // Make the click sound
    [self playSound];
    
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
        case kAlhpaSpace:
            if (touch.tapCount == 2)
            {
                [self handleSpaceDoubleTap];
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
            [titleText isEqualToString:@"'"] ||
            [titleText isEqualToString:@"‘"];
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
    [ebutton setImage:[[UIImage imageNamed:@"delete_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handlers
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTintColor = [[Colors sharedManager] buttonSpecialTintColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTintColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTintColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 +  + [[Colors sharedManager] keyboardFontSize]];
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
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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
    // Find button with space or . title
    id button = nil;
    BOOL bottomRow = NO;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = [tmp.titleLabel.text isEqualToString:@"ԲԱՑԱՏ"];
            if (properButton == YES)
            {
                bottomRow = YES;
                button = tmp;
                break;
            }
        }
        else if ([subUIView isKindOfClass:[CYRKeyboardButton class]])
        {
            CYRKeyboardButton* tmp = (CYRKeyboardButton*)subUIView;
            NSString* titleText = tmp.input;
            // Check if we found the proper button
            BOOL properButton = [titleText isEqualToString:@"."];
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
    [ebutton setTitle:@"123" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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
    CGFloat widthRatio = 0.10f;
    if (IS_IPHONE_X && bottomRow)
        widthRatio = 0.205;
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:widthRatio constant:0];
    [containerView addConstraint:buttonWidthConstraint];
}

- (void)addGlobeButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Don't add globe button for iPhoneX
    if (IS_IPHONE_X)
        return;
    
    // Find button with numbers button
    UIButton* numbutton = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = (tmp.tag == kAlphaNumber) || (tmp.tag == kAlphaABC);
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
    [ebutton setImage:[[UIImage imageNamed:@"global_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;

    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];

    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];

    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];

    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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

- (void)addDotButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // The button id to locate
    NSInteger BUTTONID = 0;
    if (IPAD)
        BUTTONID = kAlphaDismissButton;
    else
        BUTTONID = kAlphaEnter;
    
    // Find button with numbers button
    UIButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[UIButton class]])
        {
            UIButton* tmp = (UIButton*)subUIView;
            // Check if we found the proper button
            BOOL properButton = (tmp.tag == BUTTONID);
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
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    ebutton.keyColor = buttonBackgroundColor;
    ebutton.keyShadowColor = buttonBackgroundColor;
    ebutton.keyTextColor = buttonTextColor;
    ebutton.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                   size:23.0 + [[Colors sharedManager] keyboardFontSize]];
    
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

- (void)addDismissButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
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
    
    UIButton* ebutton = [[UIButton alloc] init];
    ebutton.tag = kAlphaDismissButton;
    [ebutton setImage:[[UIImage imageNamed:@"dismiss_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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
    ebutton.tag = kAlphaABC;
    [ebutton setTitle:@"ԱԲԳ" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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
    CGFloat widthRatio = 0.10f;
    if (IS_IPHONE_X)
        widthRatio = 0.205f;
    NSLayoutConstraint *buttonWidthConstraint = [NSLayoutConstraint constraintWithItem:ebutton
                                                                             attribute:NSLayoutAttributeWidth
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeWidth
                                                                            multiplier:widthRatio constant:0];
    [containerView addConstraint:buttonWidthConstraint];
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
    [ebutton setImage:[[UIImage imageNamed:@"shift_portrait"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    ebutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Add double and single tap handlers
    [ebutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [ebutton addTarget:self action:@selector(onTap:withEvent:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonSpecialTintColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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

- (void)addSymbolicButtonInRow:(UIView*)containerView sideOffset:(CGFloat)offset
{
    // Find button with . title
    CYRKeyboardButton* button = nil;
    for (UIView *subUIView in containerView.subviews) {
        if ([subUIView isKindOfClass:[CYRKeyboardButton class]])
        {
            CYRKeyboardButton* tmp = (CYRKeyboardButton*)subUIView;
            NSString* titleText = tmp.input;
            // Check if we found the proper button
            BOOL properButton = [titleText isEqualToString:@"."];
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
    ebutton.tag = kAlhpaSymbolic;
    [ebutton setTitle:@"#+=" forState:UIControlStateNormal];
    
    ebutton.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:ebutton];
    
    // Register button click handler
    [ebutton addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [ebutton addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonTextBackgroundColor];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [UIColor colorWithRed:42.f/255.f green:39.f/255.f blue:39.f/255.f alpha:1.f];
    
    // Button properties
    [ebutton setBackgroundColor:buttonBackgroundColor];
    [ebutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [ebutton setTitleColor:buttonTextColor forState:UIControlStateNormal];
    ebutton.tintColor = buttonTextColor;
    ebutton.titleLabel.font = [UIFont fontWithName:[[Colors sharedManager] keyboardFont]
                                              size:12.0 + [[Colors sharedManager] keyboardFontSize]];
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

- (void)playSound
{
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    if ([userDefaults boolForKey:@"ArmKeyboardSound"])
    {
        AudioServicesPlaySystemSound(1104);
    }
}

- (void)forwardInput:(NSString*)key
{
    // Keyboard mode management logic
    if (![key isEqualToString:@" "] && ![key isEqualToString:@"\n"] && self.alphaMode == kShifted)
    {
        // Switch to lowercase/uppercase layout
        [self addLowerCaseLayout];
        
        // Set the current mode
        self.alphaMode = kNormal;
    }
    
    [delegate alphaInputDelegateMethod:key];
}

#pragma mark Public Interface

- (void)toShiftMode
{
    // Switch to lowercase/uppercase layout
    [self addUpperCaseLayout];
    
    // Set the current mode
    self.alphaMode = kShifted;
}

- (void)toNormalMode
{
    // Switch to lowercase/uppercase layout
    [self addLowerCaseLayout];
    
    // Set the current mode
    self.alphaMode = kNormal;
}

#pragma mark CYRKeyboarBUttonInputDelegate

- (void) cyrKeyboardButtonInputDelegateMethod: (NSString *)key
{
    [self forwardInput:key];
}

@end
