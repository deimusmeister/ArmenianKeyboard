//
//  HelpForrth.m
//  ArmenianKeyboard
//
//  Created by Levon Poghosyan on 5/21/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "HelpFourth.h"
#import "SwipeView.h"

@implementation HelpFourth

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Background color
        self.backgroundColor = [UIColor whiteColor];
        
        
        // Add next button
        UIButton* nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [nextButton setImage:[UIImage imageNamed:@"SetupButton.png"] forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"SetupButton.png"] forState:UIControlStateHighlighted];
        
        nextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nextButton sizeToFit];
        [nextButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // Set the location
        CGFloat offsetX = (frame.size.width - [UIImage imageNamed:@"SetupButton.png"].size.width) / 2;
        CGFloat offsetY = frame.size.height - offsetX - [UIImage imageNamed:@"SetupButton.png"].size.height;
        nextButton.frame = CGRectMake(offsetX, offsetY,
                                      [UIImage imageNamed:@"SetupButton.png"].size.width,
                                      [UIImage imageNamed:@"SetupButton.png"].size.height);
        [self addSubview:nextButton];
        
        
        // Add Step info
        UIImageView* stepInfo = [[UIImageView alloc] init];
        stepInfo.image = [UIImage imageNamed:@"Step3.png"];
        
        CGFloat soffsetX = (frame.size.width - [UIImage imageNamed:@"Step3.png"].size.width) / 2;
        CGFloat soffsetY = frame.size.height / 12;
        
        stepInfo.frame = CGRectMake(soffsetX, soffsetY,
                                    [UIImage imageNamed:@"Step3.png"].size.width,
                                    [UIImage imageNamed:@"Step3.png"].size.height);
        [self addSubview:stepInfo];
        
        
        // Add corner logo
        UIImageView* cornerIcon = [[UIImageView alloc] init];
        cornerIcon.image = [UIImage imageNamed:@"IconCorner.png"];
        
        
        CGFloat coffsetX = frame.size.width - 1.5 * [UIImage imageNamed:@"IconCorner.png"].size.width;
        CGFloat coffsetY = [UIImage imageNamed:@"IconCorner.png"].size.height / 2;
        
        cornerIcon.frame = CGRectMake(coffsetX, coffsetY,
                                      [UIImage imageNamed:@"IconCorner.png"].size.width,
                                      [UIImage imageNamed:@"IconCorner.png"].size.height);
        [self addSubview:cornerIcon];
        
        // Add labels
        CGFloat loffsetY = stepInfo.frame.origin.y + stepInfo.frame.size.height + frame.size.height / 6;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, loffsetY, frame.size.width, 80)];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        UIColor* greenColor = [UIColor blackColor];
        UIColor* whiteColor = [UIColor grayColor];
        
        
        UIFont *font1 = [UIFont fontWithName:@"SFUIDisplay-Light" size:20];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObjectsAndKeys:font1,      NSFontAttributeName,
                                   greenColor,  NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:@"Thank You!\n" attributes: arialDict];
        
        UIFont *font2 = [UIFont fontWithName:@"SFUIDisplay-Light" size:20];
        NSDictionary *arialDict2 = [NSDictionary dictionaryWithObjectsAndKeys:font2,      NSFontAttributeName,
                                    whiteColor, NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:@"Armenian Keyboard\nis successfully installed" attributes: arialDict2];
        
        [aAttrString1 appendAttributedString:aAttrString2];
        label.attributedText = aAttrString1;
        
        [self addSubview:label];

        
        // Add paging bullets
        UIImageView* bullet1 = [[UIImageView alloc] init];
        UIImageView* bullet2 = [[UIImageView alloc] init];
        UIImageView* bullet3 = [[UIImageView alloc] init];
        UIImageView* bullet4 = [[UIImageView alloc] init];
        bullet1.image = [UIImage imageNamed:@"Bullet.png"];
        bullet2.image = [UIImage imageNamed:@"Bullet.png"];
        bullet3.image = [UIImage imageNamed:@"Bullet.png"];
        bullet4.image = [UIImage imageNamed:@"CurrentBullet.png"];
        
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
    [swipeView scrollToPage:4 duration:0.25f];
}

@end
