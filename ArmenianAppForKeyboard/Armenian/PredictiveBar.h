//
//  PredictiveBar.h
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 07/04/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpellChecker.h"

// Input handler delegate protocole
@protocol PredictiveBarDelegate <NSObject>

// define delegate method to be implemented within another class
- (void) spellerInputDelegateMethod:(NSString *)key Word:(NSString*)word;

@end

@interface PredictiveBar : UIView
{
    // Corresponding prediction option
    UIButton* leftOption;
    UIButton* centerOption;
    UIButton* rightOption;
    
    // Hunspell checker
    SpellChecker *spellChecker;
    
    // Current word
    NSString* word;
}

// Delegate member for alpha key input forwarding
@property (nonatomic, weak) id <PredictiveBarDelegate> delegate;

- (void)updateInputText:(NSString*)inputText;
- (void)loadDictionary;

@end
