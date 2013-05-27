//
//  PCNumericTextField.m
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 15..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import "PCNumericTextField.h"
#import "PCNumericText.h"

@interface PCNumericTextField ()
{
	NSString				*_prevString;
	PCNumericText			*_numericText;
	BOOL					_isChangingTextInternal;
}

@end

@implementation PCNumericTextField


- (NSInteger)currentSelectedTextPosition
{
	UITextRange *range = self.selectedTextRange;
	UITextPosition *beginning = self.beginningOfDocument;
	NSInteger ret = [self offsetFromPosition:beginning toPosition:range.start];
	return ret;
}

- (void)updateSelectedTextPosition:(NSInteger)pos
{
	if(pos < [_numericText.currencyPrefix length])
		pos = [_numericText.currencyPrefix length];
	if(pos > [self.text length])
		pos = [self.text length];
	
	UITextPosition *newCursorPosition = [self positionFromPosition:self.beginningOfDocument offset:pos];
	UITextRange *newSelectedRange = [self textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
	[self setSelectedTextRange:newSelectedRange];
}

- (NSString *)stringForDisplay:(NSString *)numeric
{
	long long iVal = [numeric longLongValue];

	// 정수 범위 밖이면 이전 값 리턴
	if(iVal == LLONG_MAX || iVal == LLONG_MIN)
		return _prevString;
	
	// 고정소수점일 경우 소수점이 없어졌다는 것은 소수점바로 뒤에서 백스페이스를 눌렀다는 의미. 이때는 이전 값 리턴
	if([self.text rangeOfString:@"."].location == NSNotFound && [_prevString rangeOfString:@"."].location != NSNotFound && _numericText.decimalCount > 0)
		return _prevString;
	
	// placeholder가 있으면 값이 비어 있을 경우 0이 출력되는 걸 방지
	if([numeric length] == 0 && [self.placeholder length] > 0)
		return @"";

	return [_numericText stringForDisplay:numeric];
}

- (void)updateNumeric
{
	// 출력을 위한 문자열 구성한 다음 커서이동을 알맞게 하기 위해...
	NSInteger currentPos = [self currentSelectedTextPosition];
	NSInteger len = [self.text length];
	NSRange dpr = [self.text rangeOfString:@".."];
	BOOL isDoublePoint = (dpr.location != NSNotFound || [self.text isEqualToString:@"."]);
	if(dpr.location != NSNotFound && currentPos > dpr.location + 1)
		isDoublePoint = NO;
	
	// 입력된 문자열에서 숫자처리에 해당되는 부분만 추출하여 출력문자열로 변환
	NSString *numericString = [_numericText stringForNumeric:self.text];
	_isChangingTextInternal = YES;
	self.text = [self stringForDisplay:numericString];
	_isChangingTextInternal = NO;
	
	// 이전 문자열과 길이가 다를 경우 커서 이동
	currentPos += ([self.text length] - len);
	
	// 고정소수점일 경우 소수입력 후 커서 이동
	if(currentPos > [self.text rangeOfString:@"."].location && _numericText.decimalCount > 0)
		currentPos += (len - [self.text length]);
	if(isDoublePoint)
		currentPos++;
	
	// 첫 입력시 화폐단위만큼 커서 이동해야 한다.
	if([_prevString length] == 0)
	{
		currentPos += [_numericText.currencyPrefix length];
	}
	
	[self updateSelectedTextPosition:currentPos];
	[self setNeedsDisplay];
	_prevString = [self.text copy];
}


#pragma mark - Getter and Setter for Properties

- (void)setText:(NSString *)text
{
	[super setText:text];
	if(!_isChangingTextInternal)
	{
		_prevString = [text copy];
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
	if(!_isChangingTextInternal)
		[self updateNumeric];
}

- (void)addEvent
{
	[self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)initVariables
{
	_numericText = [[PCNumericText alloc] init];

	self.textAlignment = NSTextAlignmentRight;
	self.keyboardType = UIKeyboardTypeDecimalPad;
	
	_prevString = @"";
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
	{
		[self addEvent];
		[self initVariables];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		[self addEvent];
		[self initVariables];
    }
    return self;
}

@end
