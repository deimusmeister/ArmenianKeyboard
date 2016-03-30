//
//  Colors.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "Colors.h"

@implementation Colors

+ (UIColor*) buttonBackgroundColor
{
    // dark mode
//    return [UIColor colorWithRed:90.f/255.f green:90.f/255.f blue:90.f/255.f alpha:1.f];
    // bright mode
    return [UIColor whiteColor];
}

+ (UIColor*) buttonTextBackgroundColor
{
    // dark mode
    //    return [UIColor whiteColor];
    // bright mode
    return [UIColor blackColor];
}

+ (UIColor*) buttonSpecialBackgroundColor
{
    // dark mode
    //    return [UIColor colorWithRed:57.f/255.f green:57.f/255.f blue:57.f/255.f alpha:1.f];
    // bright mode
    return [UIColor colorWithRed:174.f/255.f green:179.f/255.f blue:190.f/255.f alpha:1.f];
}

@end
