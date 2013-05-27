//
//  PCNumericText.m
//  testPopCornComponents
//
//  Created by Joon on 13. 5. 27..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import "PCNumericText.h"

@interface PCNumericText ()

@end

@implementation PCNumericText


- (NSString *)stringForDisplay:(NSString *)numeric
{
	long long iVal = [numeric longLongValue];
		
	// 정수값 먼저 넣고
	double dVal = [numeric doubleValue] - iVal;
	NSMutableString *iStr = [NSMutableString stringWithFormat:@"%lld", iVal];
	
	// 코머 삽입
	if(_isComma)
	{
		for(int i = [iStr length] - 1, j = 0; i >= 0; i--, j++)
		{
			unichar c = [iStr characterAtIndex:i];
			if(c >= '0' && c <= '9' && j % 3 == 0 && j > 0)
				[iStr insertString:@"," atIndex:i + 1];
		}
	}
	
	if(_decimalCount > 0)
	{
		// 소수점 이하 고정 자리수
		NSString *format = [NSString stringWithFormat:@"%%.0%df", _decimalCount];
		NSString *sDec = [NSString stringWithFormat:format, dVal];
		[iStr appendString:[sDec substringFromIndex:1]];
	}
	else if(_decimalCount == kDecialFreeCount)
	{
		// 소수점 이하 자유 자리수
		NSString *sDec = @"0";
		NSRange range = [numeric rangeOfString:@"."];
		if(range.location != NSNotFound)
			sDec = [NSString stringWithFormat:@"0%@", [numeric substringFromIndex:range.location]];
		[iStr appendString:[sDec substringFromIndex:1]];
	}
	
	// 화폐 단위 추가
	if(_currencyPrefix)
		[iStr insertString:_currencyPrefix atIndex:0];
	
	return [iStr copy];
}

- (NSString *)stringForNumeric:(NSString *)str
{
	NSString *ret = @"";
	
	// 출력된 화폐 단위 제거
	if([self.currencyPrefix length])
	{
		NSRange range = [str rangeOfString:self.currencyPrefix];
		if(range.location != NSNotFound)
			str = [str substringFromIndex:range.location + range.length];
	}
	
	// 숫자. 소수점, +, - 기호만 입력 허용
	for(int i = 0; i < [str length]; i++)
	{
		unichar c = [str characterAtIndex:i];
		if((c >= '0' && c <= '9') || (c == '.' && _decimalCount != 0 && [ret rangeOfString:@"."].location == NSNotFound) || (i == 0 && (c == '+' || c == '-')))
		{
			ret = [ret stringByAppendingFormat:@"%c", c];
		}
	}
	
	return ret;
}

- (void)initVariables
{
	_isComma = YES;
	_decimalCount = kDecialFreeCount;
}

- (id)init
{
	self = [super init];
	if(self)
	{
		[self initVariables];
	}
	return self;
}

@end
