//
//  ViewController.m
//  ArmenianAppForKeyboard
//
//  Created by Levon Poghosyan on 3/30/16.
//  Copyright © 2016 Levon Poghosyan. All rights reserved.
//

#import "ViewController.h"

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
    NSString *htmlString = @"<html><head><style type='text/css'>html,body {margin: 0;padding: 0;width: 100%;height: 100%;}html {display: table;}body {display: table-cell;vertical-align: middle;padding: 20px;text-align: center;-webkit-text-size-adjust: none;}p { font-family: Helvetica, Sans-Serif; } "
    
    "</style></head><body><h2><strong>Armenian keyboard extension is installed !</strong></h2>"
    
    "<h2><strong>Perform following steps to activate it</strong></h2>"
    
    "<p>1. Open your Settings. The Settings app can be found on your Device&rsquo;s Home Screen. In the Settings Menu, select the General option.</p>"
    
    "<p>2. Scroll down until you find the Keyboard menu in your General settings. Tap it to open the Keyboard menu. Select the Keyboards submenu.</p>"
    
    "<p>3. In the Keyboards submenu, you will see a list of your installed keyboards. Tap the Add New Keyboard button to open a list of available keyboards. Select Armenian from the list.</p>"
    
    "<p>4. To enable keyboard sound select the newly added Armenian Keyboard switch 'Allow Full Access' to on and set the sound setting above.</p>"
    
    "<br><br>"
    
    "</body></html>​";
    
    UITextView* soundText = [[UITextView alloc] init];
    soundText.text = @"Keyboard Sound ";
    [soundText setFont:[UIFont systemFontOfSize:20]];
    UISwitch *soundSwitch = [[UISwitch alloc] init];
    [soundSwitch addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:soundText];
    [soundText sizeToFit];
    [self.view addSubview:soundSwitch];
    
    CGFloat textWidth = soundText.frame.size.width;
    textWidth = textWidth + textWidth / 3;
    CGFloat offsetWidth = (self.view.frame.size.width - textWidth) / 2;
    CGFloat offsetHeight = 20.f;
    
    soundText.frame = CGRectMake(offsetWidth,
                                 offsetHeight,
                                 soundText.frame.size.width,
                                 soundText.frame.size.height);
    soundSwitch.frame = CGRectMake(offsetWidth + textWidth - soundSwitch.frame.size.width,
                                   offsetHeight + 5,
                                   soundSwitch.frame.size.width,
                                   soundSwitch.frame.size.height);
    
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    soundSwitch.on = [userDefaults boolForKey:@"ArmKeyboardSound"];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0,
                               soundSwitch.frame.origin.y + soundSwitch.frame.size.height,
                               self.view.frame.size.width,
                               self.view.frame.size.height - soundSwitch.frame.origin.y + soundSwitch.frame.size.height);
    
    [webView loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:webView];
    
    NSString *bodyStyleVertical = @"document.getElementsByTagName('body')[0].style.verticalAlign = 'middle';";
    NSString *bodyStyleHorizontal = @"document.getElementsByTagName('body')[0].style.textAlign = 'center';";
    NSString *mapStyle = @"document.getElementById('mapid').style.margin = 'auto';";
    
    [webView stringByEvaluatingJavaScriptFromString:bodyStyleVertical];
    [webView stringByEvaluatingJavaScriptFromString:bodyStyleHorizontal];
    [webView stringByEvaluatingJavaScriptFromString:mapStyle];
    
    webView.backgroundColor = [UIColor whiteColor];
    webView.opaque = FALSE;
    webView.userInteractionEnabled = YES;
    [webView.scrollView setScrollEnabled:YES];
    [webView.scrollView setBounces:NO];
}

- (IBAction) flip: (id) sender {
    UISwitch *onoff = (UISwitch *) sender;
    NSUserDefaults* userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.levonpoghosyan.armeniankeyboard"];
    [userDefaults setBool:onoff.on forKey:@"ArmKeyboardSound"];
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
