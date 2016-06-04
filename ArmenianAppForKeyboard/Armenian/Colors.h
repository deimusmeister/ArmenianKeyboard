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
    BOOL isBoldEnabled;
}

@property (nonatomic, strong) id <UITextDocumentProxy> textDocumentProxy;
@property (nonatomic, assign) BOOL isBoldEnabled;

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

- (NSString*) keyboardFont;
- (int) keyboardFontSize;

@end
