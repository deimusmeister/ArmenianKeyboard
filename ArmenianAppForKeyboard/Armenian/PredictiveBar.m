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

@synthesize delegate;

dispatch_queue_t suggestionsQueue;

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
        
        // Instantiate spellchecker
        spellChecker = [[SpellChecker alloc] init];
        word = [[NSString alloc] init];
        
        // Initialize the dispatch queue
        suggestionsQueue = dispatch_queue_create("spelling suggestions queue", NULL);
    }
    return self;
}

-(void) suspendSpeller
{
    // Release speller resources
    [spellChecker suspend];
}

-(void) setupOptionButton:(UIButton*)option
{
    option.translatesAutoresizingMaskIntoConstraints = NO;
    option.titleLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    [self addSubview:option];
    
    // Register button click handlers
    [option addTarget:self action:@selector(buttonUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [option addTarget:self action:@selector(buttonUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [option addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    
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
    dispatch_async(suggestionsQueue, ^{
        NSArray* suggestions = [NSArray arrayWithArray:[spellChecker getSuggestionsForWord:inputText]];
        dispatch_async(dispatch_get_main_queue(), ^{
            word = [NSString stringWithString:inputText];
            
            // Set the defaults
            [leftOption setTitle:inputText forState:UIControlStateNormal];
            [centerOption setTitle:@"" forState:UIControlStateNormal];
            [rightOption setTitle:@"" forState:UIControlStateNormal];
            
            if (suggestions.count > 0)
                [leftOption setTitle:[suggestions objectAtIndex:0] forState:UIControlStateNormal];
            
            if (suggestions.count > 1)
                [centerOption setTitle:[suggestions objectAtIndex:1] forState:UIControlStateNormal];
            
            if (suggestions.count > 2)
                [rightOption setTitle:[suggestions objectAtIndex:2] forState:UIControlStateNormal];
            
        });
    });
}

- (void)loadDictionary
{
    if (spellChecker != nil)
    {
        dispatch_async(suggestionsQueue, ^{
            [spellChecker updateLanguage:@"hy-AM"];
        });
    }
}

- (void)buttonUpInside:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSuggestionBackgroundColor];
    [button setBackgroundColor:buttonBackgroundColor];
    
    // Forward the option to input field
    [delegate spellerInputDelegateMethod:button.titleLabel.text Word:word];
}

- (void)buttonDown:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSuggestionSelectedBackgroundColor];
    [button setBackgroundColor:buttonBackgroundColor];
}

- (void)buttonUpOutside:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    // Button specific colors
    UIColor* buttonBackgroundColor = [[Colors sharedManager] buttonSuggestionBackgroundColor];
    [button setBackgroundColor:buttonBackgroundColor];
}

@end
