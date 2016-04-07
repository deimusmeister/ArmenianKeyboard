//
//  PredictiveBar.h
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 07/04/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PredictiveBar : UIView
{
    // Corresponding prediction option
    UIButton* leftOption;
    UIButton* centerOption;
    UIButton* rightOption;
}

- (void)updateInputText:(NSString*)inputText;

@end
