//
//  TestNumericTextFieldViewController.m
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 15..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import "TestNumericTextFieldViewController.h"
#import "PCNumericTextField.h"
#import "PCNumericLabel.h"

@interface TestNumericTextFieldViewController ()
{
	IBOutlet PCNumericTextField *numericField1;
	IBOutlet PCNumericTextField *numericField2;
	IBOutlet PCNumericLabel *numericLabel;
}

- (IBAction)onChange:(id)sender;

@end

@implementation TestNumericTextFieldViewController

- (IBAction)onChange:(id)sender
{
	numericLabel.text = [NSString stringWithFormat:@"%d", (int)([numericField1.numericString doubleValue] * [numericField2.numericString doubleValue])];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.title = @"Numeric and Currency";
	
	numericField1.currencyPrefix = @"$";
	numericField1.text = @"12345";
	numericField1.decimalCount = 2;
	[numericField1 becomeFirstResponder];

	numericField2.currencyPrefix = @"\\";
	numericField2.text = @"1085";
	
	numericLabel.text = @"1085";
	numericLabel.currencyPrefix = @"\\";
	
	[self onChange:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	numericField1 = nil;
	numericField2 = nil;
	numericLabel = nil;
	[super viewDidUnload];
}

@end
