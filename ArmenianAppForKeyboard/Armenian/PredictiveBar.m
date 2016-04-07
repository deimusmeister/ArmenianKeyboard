//
//  PredictiveBar.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 07/04/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "PredictiveBar.h"
#import "Colors.h"

@implementation PredictiveBar

- (id)init
{
    if (self = [super init])
    {
        // Add left option button
        leftOption = [[UIButton alloc] init];
        [self setupOptionButton:leftOption];
        
        // Add center option button
        centerOption = [[UIButton alloc] init];
        [self setupOptionButton:centerOption];
        
        // Add right option button
        rightOption = [[UIButton alloc] init];
        [self setupOptionButton:rightOption];
        
        // Vertical constraints
        NSDictionary* views = NSDictionaryOfVariableBindings( leftOption, centerOption, rightOption );
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                              @"H:|[leftOption]-1-[centerOption(==leftOption)]-1-[rightOption(==leftOption)]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views]];
    }
    return self;
}

-(void) setupOptionButton:(UIButton*)option
{
    option.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:option];
    
    // Register button click handlers
    //        [leftOption addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSpecialBackgroundColor];
    UIColor* buttonTextColor = [[Colors sharedManager] buttonSuggestionTextColor];
    
    // Button properties
    [option setBackgroundColor:buttonBackgroundColor];
    [option.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [option setTitleColor:buttonTextColor forState:UIControlStateNormal];
    option.titleLabel.font = [UIFont fontWithName:@"ArianAMU" size:19.0];
    
    // Bottom constraint
    NSLayoutConstraint *buttonBottomConstraint = [NSLayoutConstraint constraintWithItem:option
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:self
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0 constant:0.0];
    
    [self addConstraint:buttonBottomConstraint];
    
    // Top constraint
    NSLayoutConstraint *buttonTopConstraint = [NSLayoutConstraint constraintWithItem:option
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0 constant:0.0];
    [self addConstraint:buttonTopConstraint];
}

- (void)updateInputText:(NSString*)inputText
{
    [leftOption setTitle:inputText forState:UIControlStateNormal];
    [centerOption setTitle:inputText forState:UIControlStateNormal];
    [rightOption setTitle:inputText forState:UIControlStateNormal];
}

@end
