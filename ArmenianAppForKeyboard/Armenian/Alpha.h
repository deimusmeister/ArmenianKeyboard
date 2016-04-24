//
//  Alpha.h
//  ArmenianKeyboard
//
//  Created by Levon Poghosyan on 13/01/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYRKeyboardButton.h"

// Special button tags
#define kAlphaEnter             400
#define kAlphaDelete            401
#define kAlphaShift             402
#define kAlphaNumber            403
#define kAlphaABC               404
#define kAlphaOption            405
#define kAlphaSearchButton      406
#define kAlphaGlobeButton       407
#define kAlphaDotButton         408
#define kAlhpaSpace             409
#define kAlhpaSymbolic          410

// Input handler delegate protocole
@protocol AlphaInputDelegate <NSObject>

// define delegate method to be implemented within another class
- (void) alphaSpecialKeyInputDelegateMethod:(NSInteger)tag;
- (void) alphaInputDelegateMethod:(NSString *)key;
- (void) alhpaInputRemoveCharacter;

@end

// Define Alpha class
@interface Alpha : UIView <CYRKeyboarBUttonInputDelegate>
{
    // Delete button timer
    NSTimer* _TimerDeleteButton;
}

// Delegate member for alpha key input forwarding
@property (nonatomic, weak) id <AlphaInputDelegate> delegate;

// Represents the current state of alpha keyboad possible values are :
//      kLowerCase        1
//      kUpperCase        2
//      kOption1Case      3
//      kOption2Case      4
@property (nonatomic) NSUInteger alphaMode;

// Switch keyboard to shifted mode
- (void)toShiftMode;

// Switch keyboard to normal mode
- (void)toNormalMode;

@end
