//
//  Colors.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "Colors.h"

@implementation Colors

@synthesize textDocumentProxy;

+ (id)sharedManager
{
    static Colors *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (UIColor*) buttonBackgroundColor
{
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark)
    {
        // dark mode
        return [UIColor colorWithRed:90.f/255.f green:90.f/255.f blue:90.f/255.f alpha:1.f];
    }
    else
    {
        // bright mode
        return [UIColor whiteColor];
    }
}

- (UIColor*) buttonTextBackgroundColor
{
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark)
    {
        // dark mode
        return [UIColor whiteColor];
    }
    else
    {
        // bright mode
        return [UIColor blackColor];
    }
}

- (UIColor*) buttonSpecialBackgroundColor
{
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark)
    {
        // dark mode
        return [UIColor colorWithRed:57.f/255.f green:57.f/255.f blue:57.f/255.f alpha:1.f];
    }
    else
    {
        // bright mode
        return [UIColor colorWithRed:174.f/255.f green:179.f/255.f blue:190.f/255.f alpha:1.f];
    }
}

- (UIColor*) buttonSpecialBackgroundColorSelected
{
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark)
    {
        // dark mode
        return [UIColor colorWithRed:174.f/255.f green:179.f/255.f blue:190.f/255.f alpha:1.f];
    }
    else
    {
        // bright mode
        return [UIColor whiteColor];
    }
}

@end
