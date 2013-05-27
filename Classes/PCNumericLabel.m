//
//  PCNumericLabel.m
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 27..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import "PCNumericLabel.h"
#import "PCNumericText.h"

@interface PCNumericLabel ()
{
	PCNumericText			*_numericText;
	BOOL					_isChangingTextInternal;
}

@end


@implementation PCNumericLabel

- (void)updateNumeric
{
	// 입력된 문자열에서 숫자처리에 해당되는 부분만 추출하여 출력문자열로 변환
	NSString *numericString = [_numericText stringForNumeric:self.text];
	_isChangingTextInternal = YES;
	self.text = [_numericText stringForDisplay:numericString];
	_isChangingTextInternal = NO;
	[self setNeedsDisplay];
}


#pragma mark - Getter and Setter for Properties

- (void)setText:(NSString *)text
{
	[super setText:text];
	if(!_isChangingTextInternal)
	{
		[self updateNumeric];
	}
}

- (int)decimalCount
{
	return _numericText.decimalCount;
}

- (void)setDecimalCount:(int)decimalCount
{
	_numericText.decimalCount = decimalCount;
	[self updateNumeric];
}

- (NSString *)numericString
{
	return [_numericText stringForNumeric:self.text];
}

- (BOOL)isComma
{
	return _numericText.isComma;
}

- (void)setIsComma:(BOOL)isComma
{
	_numericText.isComma = isComma;
	[self updateNumeric];
}

- (NSString *)currencyPrefix
{
	return _numericText.currencyPrefix;
}

- (void)setCurrencyPrefix:(NSString *)currencyPrefix
{
	_numericText.currencyPrefix = currencyPrefix;
	[self updateNumeric];
}


#pragma mark - Initialize

- (void)textFieldDidChange:(id)sender
{
	[self updateNumeric];
}

- (void)initVariables
{
	_numericText = [[PCNumericText alloc] init];
	
	self.textAlignment = NSTextAlignmentRight;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
		[self initVariables];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self initVariables];
    }
    return self;
}


@end
