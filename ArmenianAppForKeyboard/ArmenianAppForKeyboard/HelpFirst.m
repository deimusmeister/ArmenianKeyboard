//
//  HelpFirst.m
//  ArmenianKeyboard
//
//  Created by Levon Poghosyan on 5/21/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "HelpFirst.h"
#import "SwipeView.h"

@implementation HelpFirst

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Background color
        self.backgroundColor = [UIColor whiteColor];
        
        // Add next button
        UIButton* nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [nextButton setImage:[UIImage imageNamed:@"NextButton.png"] forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"NextButton.png"] forState:UIControlStateHighlighted];
        
        nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nextButton sizeToFit];
        [nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // Set the location
        CGFloat offsetX = (frame.size.width - [UIImage imageNamed:@"NextButton.png"].size.width) / 2;
        CGFloat offsetY = frame.size.height - offsetX - [UIImage imageNamed:@"NextButton.png"].size.height;
        nextButton.frame = CGRectMake(offsetX, offsetY,
                                      [UIImage imageNamed:@"NextButton.png"].size.width,
                                      [UIImage imageNamed:@"NextButton.png"].size.height);
        [self addSubview:nextButton];
        
        
        // Add logo
        UIImageView* homeIcon = [[UIImageView alloc] init];
        homeIcon.image = [UIImage imageNamed:@"IconHome.png"];
        
        
        CGFloat hoffsetX = (frame.size.width - [UIImage imageNamed:@"IconHome.png"].size.width) / 2;
        CGFloat hoffsetY = frame.size.height / 6;
        
        homeIcon.frame = CGRectMake(hoffsetX, hoffsetY,
                                    [UIImage imageNamed:@"IconHome.png"].size.width,
                                    [UIImage imageNamed:@"IconHome.png"].size.height);
        [self addSubview:homeIcon];
        
        // Add labels
        CGFloat loffsetY = homeIcon.frame.origin.y + homeIcon.frame.size.height + frame.size.height / 12;
    
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, loffsetY, frame.size.width, 90)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        UIColor* greenColor = [UIColor blackColor];
        UIColor* whiteColor = [UIColor grayColor];
        
        
        UIFont *font1 = [UIFont fontWithName:@"SFUIDisplay-Light" size:20];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObjectsAndKeys:font1,      NSFontAttributeName,
                                                                            greenColor,  NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Welcome To\nArmenian Keyboard\n" attributes: arialDict];
        
        UIFont *font2 = [UIFont fontWithName:@"SFUIDisplay-Light" size:15];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObjectsAndKeys:font2,      NSFontAttributeName,
                                                                              whiteColor, NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"First you need to " attributes: arialDict2];
        
        UIFont *font3 = [UIFont boldSystemFontOfSize:15];
        NSDictionary *arialDict3 = [NSDictionary dictionaryWithObjectsAndKeys:font3,      NSFontAttributeName,
                                                                              whiteColor, NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString3 = [[NSMutableAttributedString alloc] initWithString:@"install\n" attributes: arialDict3];

        NSDictionary *arialDict4 = [NSDictionary dictionaryWithObjectsAndKeys:font2,      NSFontAttributeName,
                                                                              whiteColor, NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString4 = [[NSMutableAttributedString alloc] initWithString:@"your new keyboard!"
                                                                                         attributes: arialDict4];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        [aAttrString1 appendAttributedString:aAttrString3];
        [aAttrString1 appendAttributedString:aAttrString4];
        label.attributedText = aAttrString1;
        
        [self addSubview:label];
        
        // Add paging bullets
        UIImageView* bullet1 = [[UIImageView alloc] init];
        UIImageView* bullet2 = [[UIImageView alloc] init];
        UIImageView* bullet3 = [[UIImageView alloc] init];
        UIImageView* bullet4 = [[UIImageView alloc] init];
        bullet1.image = [UIImage imageNamed:@"CurrentBullet.png"];
        bullet2.image = [UIImage imageNamed:@"Bullet.png"];
        bullet3.image = [UIImage imageNamed:@"Bullet.png"];
        bullet4.image = [UIImage imageNamed:@"Bullet.png"];
        
        CGFloat bulletSize = [UIImage imageNamed:@"Bullet.png"].size.height;
        
        CGFloat boffsetX = (frame.size.width - 85) / 2;
        CGFloat boffsetY = nextButton.frame.origin.y - bulletSize - 20;
        
        CGFloat gap = (85 - 4 * bulletSize) / 3;
        
        bullet1.frame = CGRectMake(boffsetX, boffsetY, bulletSize, bulletSize);
        bullet2.frame = CGRectMake(bullet1.frame.origin.x + bulletSize + gap, boffsetY, bulletSize, bulletSize);
        bullet3.frame = CGRectMake(bullet2.frame.origin.x + bulletSize + gap, boffsetY, bulletSize, bulletSize);
        bullet4.frame = CGRectMake(bullet3.frame.origin.x + bulletSize + gap, boffsetY, bulletSize, bulletSize);
        
        [self addSubview:bullet1];
        [self addSubview:bullet2];
        [self addSubview:bullet3];
        [self addSubview:bullet4];
    
    }
    return self;
}

- (void)buttonClick:(id)sender
{
    SwipeView* swipeView = (SwipeView*)self.superview.superview;
    [swipeView scrollToPage:1 duration:0.25f];
}

@end
