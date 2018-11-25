//
//  ViewController.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "ViewController.h"
#import "SwipeView.h"
#import "HelpFirst.h"
#import "HelpSecond.h"
#import "HelpThird.h"
#import "HelpFourth.h"
#import "KeyboardSetup.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
//    NSString *htmlString = @"<html><head><style type='text/css'>html,body {margin: 0;padding: 0;width: 100%;height: 100%;}html {display: table;}body {display: table-cell;vertical-align: middle;padding: 20px;text-align: center;-webkit-text-size-adjust: none;}p { font-family: Helvetica, Sans-Serif; } "
//    
//    "</style></head><body><h2><strong>Armenian keyboard extension is installed !</strong></h2>"
//    
//    "<h2><strong>Perform following steps to activate it</strong></h2>"
//    
//    "<p>1. Open your Settings. The Settings app can be found on your Device&rsquo;s Home Screen. In the Settings Menu, select the General option.</p>"
//    
//    "<p>2. Scroll down until you find the Keyboard menu in your General settings. Tap it to open the Keyboard menu. Select the Keyboards submenu.</p>"
//    
//    "<p>3. In the Keyboards submenu, you will see a list of your installed keyboards. Tap the Add New Keyboard button to open a list of available keyboards. Select Armenian from the list.</p>"
//    
//    "<p>4. To enable keyboard sound select the newly added Armenian Keyboard switch 'Allow Full Access' to on and set the sound setting above.</p>"
//    
//    "<br><br>"
//    
//    "</body></html>​";
//    
//    // Add sound option
//    UITextView* soundText = [[UITextView alloc] init];
//    soundText.text = @"Keyboard Sound ";
//    [soundText setFont:[UIFont systemFontOfSize:20]];
//    UISwitch *soundSwitch = [[UISwitch alloc] init];
//    [soundSwitch addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:soundText];
//    [soundText sizeToFit];
//    [self.view addSubview:soundSwitch];
//    
//    CGFloat textWidth = soundText.frame.size.width;
//    textWidth = textWidth + textWidth / 3;
//    CGFloat offsetWidth = (self.view.frame.size.width - textWidth) / 2;
//    CGFloat offsetHeight = 20.f;
//    
//    soundText.frame = CGRectMake(offsetWidth,
//                                 offsetHeight,
//                                 soundText.frame.size.width,
//                                 soundText.frame.size.height);
//    soundSwitch.frame = CGRectMake(offsetWidth + textWidth - soundSwitch.frame.size.width,
//                                   offsetHeight + 5,
//                                   soundSwitch.frame.size.width,
//                                   soundSwitch.frame.size.height);
//    
//    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//    soundSwitch.on = [userDefaults boolForKey:@"ArmKeyboardSound"];
//    
//    // Add prediction option
//    UITextView* predictionText = [[UITextView alloc] init];
//    predictionText.text = @"Input Prediction ";
//    [predictionText setFont:[UIFont systemFontOfSize:20]];
//    UISwitch *predictionSwitch = [[UISwitch alloc] init];
//    [predictionSwitch addTarget: self action: @selector(pflip:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:predictionText];
//    [predictionText sizeToFit];
//    [self.view addSubview:predictionSwitch];
//    
//    textWidth = predictionText.frame.size.width;
//    textWidth = textWidth + textWidth / 3;
//    offsetWidth = (self.view.frame.size.width - textWidth) / 2;
//    offsetHeight = 20.f + 40.f;
//    
//    predictionText.frame = CGRectMake(offsetWidth,
//                                 offsetHeight,
//                                 predictionText.frame.size.width,
//                                 predictionText.frame.size.height);
//    predictionSwitch.frame = CGRectMake(offsetWidth + textWidth - predictionSwitch.frame.size.width,
//                                   offsetHeight + 5,
//                                   predictionSwitch.frame.size.width,
//                                   predictionSwitch.frame.size.height);
//    
//    if ([userDefaults objectForKey:@"ArmKeyboardPrediction"] == nil)
//    {
//        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//        [userDefaults setBool:YES forKey:@"ArmKeyboardPrediction"];
//        [userDefaults synchronize];
//    }
//    predictionSwitch.on = [userDefaults boolForKey:@"ArmKeyboardPrediction"];
//    
//    // Add bold text option
//    UITextView* boldText = [[UITextView alloc] init];
//    boldText.text = @"Bold Text ";
//    [boldText setFont:[UIFont systemFontOfSize:20]];
//    UISwitch *boldSwitch = [[UISwitch alloc] init];
//    [boldSwitch addTarget: self action: @selector(bflip:) forControlEvents:UIControlEventValueChanged];
//    
//    [self.view addSubview:boldText];
//    [boldText sizeToFit];
//    [self.view addSubview:boldSwitch];
//    
//    textWidth = boldText.frame.size.width;
//    textWidth = textWidth + textWidth / 2;
//    offsetWidth = (self.view.frame.size.width - textWidth) / 2;
//    offsetHeight = 20.f + 40.f + 40.f;
//    
//    boldText.frame = CGRectMake(offsetWidth,
//                                offsetHeight,
//                                boldText.frame.size.width,
//                                boldText.frame.size.height);
//    boldSwitch.frame = CGRectMake(offsetWidth + textWidth - boldSwitch.frame.size.width,
//                                  offsetHeight + 5,
//                                  boldSwitch.frame.size.width,
//                                  boldSwitch.frame.size.height);
//    
//    if ([userDefaults objectForKey:@"ArmKeyboardBoldText"] == nil)
//    {
//        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//        [userDefaults setBool:NO forKey:@"ArmKeyboardBoldText"];
//        [userDefaults synchronize];
//    }
//    boldSwitch.on = [userDefaults boolForKey:@"ArmKeyboardBoldText"];
//    
//    // Add the intruction text
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.frame = CGRectMake(0,
//                               boldSwitch.frame.origin.y + boldSwitch.frame.size.height + 10,
//                               self.view.frame.size.width,
//                               self.view.frame.size.height - boldSwitch.frame.origin.y + boldSwitch.frame.size.height);
//    
//    [webView loadHTMLString:htmlString baseURL:nil];
//    [self.view addSubview:webView];
//    
//    NSString *bodyStyleVertical = @"document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';";
//    NSString *bodyStyleHorizontal = @"document.getElementsByTagName('body')[0].style.textAlign = 'center';";
//    NSString *mapStyle = @"document.getElementById('mapid').style.margin = 'auto';";
//    
//    [webView stringByEvaluatingJavaScriptFromString:bodyStyleVertical];
//    [webView stringByEvaluatingJavaScriptFromString:bodyStyleHorizontal];
//    [webView stringByEvaluatingJavaScriptFromString:mapStyle];
//    
//    webView.backgroundColor = [UIColor whiteColor];
//    webView.opaque = FALSE;
//    webView.userInteractionEnabled = YES;
//    [webView.scrollView setScrollEnabled:YES];
//    [webView.scrollView setBounces:NO];
    
    // Set the default values if no setting is configured
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    if ([userDefaults objectForKey:@"ArmKeyboardPrediction"] == nil)
    {
        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
        [userDefaults setBool:YES forKey:@"ArmKeyboardPrediction"];
        [userDefaults synchronize];
    }
    if ([userDefaults objectForKey:@"ArmKeyboardBoldText"] == nil)
    {
        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
        [userDefaults setBool:NO forKey:@"ArmKeyboardBoldText"];
        [userDefaults synchronize];
    }
    if ([userDefaults objectForKey:@"ArmKeyboardAutoCapitalization"] == nil)
    {
        NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
        [userDefaults setBool:YES forKey:@"ArmKeyboardAutoCapitalization"];
        [userDefaults synchronize];
    }
    
    SwipeView* swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    swipeView.delegate = self;
    swipeView.dataSource = self;
    swipeView.bounces = NO;
    
    [self.view addSubview:swipeView];
    
    if ([userDefaults objectForKey:@"ArmenianInitialized"] != nil)
    {
        [swipeView scrollToPage:4 duration:0.0f];
    }
}

-(BOOL) shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}
//- (IBAction) flip: (id) sender {
//    UISwitch *onoff = (UISwitch *) sender;
//    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//    [userDefaults setBool:onoff.on forKey:@"ArmKeyboardSound"];
//    [userDefaults synchronize];
//}
//
//- (IBAction) pflip: (id) sender {
//    UISwitch *onoff = (UISwitch *) sender;
//    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//    [userDefaults setBool:onoff.on forKey:@"ArmKeyboardPrediction"];
//    [userDefaults synchronize];
//}
//
//- (IBAction) bflip: (id) sender {
//    UISwitch *onoff = (UISwitch *) sender;
//    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
//    [userDefaults setBool:onoff.on forKey:@"ArmKeyboardBoldText"];
//    [userDefaults synchronize];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 5;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIView* page;
    switch (index) {
        case 0:
            page = [[HelpFirst alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            break;
            
        case 1:
            page = [[HelpSecond alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            break;
            
        case 2:
            page = [[HelpThird alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            break;
            
        case 3:
            page = [[HelpFourth alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            break;
            
        case 4:
        {
            NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
            [userDefaults setBool:YES forKey:@"ArmenianInitialized"];
            page = [[KeyboardSetup alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            break;
        }
    }
    return page;
}

@end
