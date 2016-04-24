//
//  Colors.h
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Colors : NSObject
{
    id textDocumentProxy;
}

@property (nonatomic, strong) id <UITextDocumentProxy> textDocumentProxy;

+ (id)sharedManager;

- (UIColor*) buttonBackgroundColor;
- (UIColor*) buttonTextBackgroundColor;
- (UIColor*) buttonSpecialBackgroundColor;
- (UIColor*) buttonSpecialTintColor;
- (UIColor*) buttonSpecialTintSelectedColor;
- (UIColor*) buttonSpecialBackgroundColorSelected;

- (UIColor*) buttonSuggestionBackgroundColor;
- (UIColor*) buttonSuggestionTextColor;
- (UIColor*) buttonSuggestionSelectedBackgroundColor;

- (UIColor*) buttonShadowColor;

- (UIColor*) backgroundColor;

@end